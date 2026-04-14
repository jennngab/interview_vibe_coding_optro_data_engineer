-- Agent Performance Model
-- Vibe coded with AI assistant
-- Grain: one row per agent (aggregated)
-- Last updated: 2025-04-10

WITH ticket_data AS (

    SELECT
        t.*,
        u.name        AS agent_name,
        u.email       AS agent_email,

        -- TTFR: first time status changed to 'open'
        (
            SELECT MIN(ta.created_at)
            FROM zendesk.ticket_audits ta,
                 jsonb_array_elements(ta.events) AS e
            WHERE ta.ticket_id = t.id
              AND e->>'type'       = 'Change'
              AND e->>'field_name' = 'status'
              AND e->>'value'      = 'open'
        ) AS first_open_at,

        -- Full resolution: last time status changed to 'solved'
        (
            SELECT MAX(ta.created_at)
            FROM zendesk.ticket_audits ta,
                 jsonb_array_elements(ta.events) AS e
            WHERE ta.ticket_id = t.id
              AND e->>'type'       = 'Change'
              AND e->>'field_name' = 'status'
              AND e->>'value'      = 'solved'
        ) AS resolved_at

    FROM zendesk.tickets t
    LEFT JOIN zendesk.users u ON t.assignee_id = u.id
    WHERE t.status IN ('solved', 'closed')

),

agent_metrics AS (

    SELECT
        assignee_id,
        agent_name,
        agent_email,
        COUNT(*) AS total_tickets,

        ROUND(AVG(EXTRACT(EPOCH FROM (first_open_at - created_at)) / 60), 1)
            AS avg_ttfr_minutes,

        ROUND(AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600), 1)
            AS avg_resolution_hours,

        -- SLA thresholds: urgent=1h, high=4h, normal=8h, low=24h
        SUM(CASE
            WHEN priority = 'urgent' AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 > 1  THEN 1
            WHEN priority = 'high'   AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 > 4  THEN 1
            WHEN priority = 'normal' AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 > 8  THEN 1
            WHEN priority = 'low'    AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 > 24 THEN 1
            ELSE 0
        END) AS sla_breach_count,

        ROUND(
            100.0 * SUM(CASE
                WHEN priority = 'urgent' AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 <= 1  THEN 1
                WHEN priority = 'high'   AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 <= 4  THEN 1
                WHEN priority = 'normal' AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 <= 8  THEN 1
                WHEN priority = 'low'    AND EXTRACT(EPOCH FROM (first_open_at - created_at)) / 3600 <= 24 THEN 1
                ELSE 0
            END) / COUNT(*),
        1) AS sla_met_pct

    FROM ticket_data
    GROUP BY assignee_id, agent_name, agent_email

)

SELECT * FROM agent_metrics
ORDER BY avg_ttfr_minutes ASC
