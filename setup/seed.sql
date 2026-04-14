-- ============================================================
-- ZENDESK SYNTHETIC SEED DATA  (~335 rows)
-- Optro Data Engineer Vibe Coding Interview
-- ============================================================

-- ORGANIZATIONS (3 rows)
INSERT INTO zendesk.organizations (id, name, created_at, domain_names, tags, notes) VALUES
(1001, 'Acme Enterprise',      '2024-01-15 09:00:00+00', '["acme.com"]',        '["enterprise"]', 'Fortune 500 client, renewal Q3 2025'),
(1002, 'Cascade Technologies', '2024-03-10 08:00:00+00', '["cascadetech.net"]', '["at-risk"]',    'High churn risk, escalation history'),
(1003, 'Echo Startup',         '2024-06-01 11:00:00+00', '["echostartup.io"]',  '["startup"]',    'Small team, price-sensitive');

-- USERS (23 rows)
-- id=1       : system user — author of all automated trigger events
-- ids 2001-2010: human agents  (agent_type = 'human')
-- ids 2011-2013: AI bot agents (agent_type = 'ai_bot')
-- ids 3001-3006: end-users linked to orgs
INSERT INTO zendesk.users (id, name, email, role, agent_type, organization_id, created_at, active, time_zone, external_id) VALUES
(1,    'Zendesk System',  'system@zendesk.internal',    'admin',    NULL,     NULL, '2023-01-01 00:00:00+00', TRUE, 'UTC',                 NULL),
(1001, 'Sarah Chen',      'sarah.chen@optro.com',       'admin',    NULL,     NULL, '2023-06-01 09:00:00+00', TRUE, 'America/New_York',    'EMP-1001'),
(2001, 'Alex Torres',     'alex.torres@optro.com',      'agent',    'human',  NULL, '2023-08-01 09:00:00+00', TRUE, 'America/New_York',    'EMP-2001'),
(2002, 'Jordan Kim',      'jordan.kim@optro.com',       'agent',    'human',  NULL, '2023-08-01 09:00:00+00', TRUE, 'America/Chicago',     'EMP-2002'),
(2003, 'Priya Sharma',    'priya.sharma@optro.com',     'agent',    'human',  NULL, '2023-09-15 09:00:00+00', TRUE, 'America/Los_Angeles', 'EMP-2003'),
(2004, 'Derek Walsh',     'derek.walsh@optro.com',      'agent',    'human',  NULL, '2023-09-15 09:00:00+00', FALSE, 'Europe/London',       'EMP-2004'),
(2005, 'Mia Johnson',     'mia.johnson@optro.com',      'agent',    'human',  NULL, '2023-10-01 09:00:00+00', TRUE, 'America/New_York',    'EMP-2005'),
(2006, 'Tariq Hassan',    'tariq.hassan@optro.com',     'agent',    'human',  NULL, '2023-10-01 09:00:00+00', TRUE, 'Asia/Dubai',          'EMP-2006'),
(2007, 'Elena Novak',     'elena.novak@optro.com',      'agent',    'human',  NULL, '2023-11-01 09:00:00+00', TRUE, 'Europe/Prague',       'EMP-2007'),
(2008, 'Chris Brown',     'chris.brown@optro.com',      'agent',    'human',  NULL, '2023-11-01 09:00:00+00', TRUE, 'America/Denver',      'EMP-2008'),
(2009, 'Nina Okonkwo',    'nina.okonkwo@optro.com',     'agent',    'human',  NULL, '2024-01-15 09:00:00+00', TRUE, 'Africa/Lagos',        'EMP-2009'),
(2010, 'Sam Lee',         'sam.lee@optro.com',          'agent',    'human',  NULL, '2024-01-15 09:00:00+00', TRUE, 'Asia/Tokyo',          'EMP-2010'),
(2011, 'Aria Bot',        'aria-bot@optro-ai.com',      'agent',    'ai_bot', NULL, '2024-03-01 00:00:00+00', TRUE, 'UTC',                 'AI-BOT-001'),
(2012, 'Zara Bot',        'zara-bot@optro-ai.com',      'agent',    'ai_bot', NULL, '2024-03-01 00:00:00+00', TRUE, 'UTC',                 'AI-BOT-002'),
(2013, 'Max Bot',         'max-bot@optro-ai.com',       'agent',    'ai_bot', NULL, '2024-04-01 00:00:00+00', TRUE, 'UTC',                 'AI-BOT-003'),
(3001, 'Robert Zhang',    'r.zhang@acme.com',           'end-user', NULL, 1001, '2024-01-20 10:00:00+00', TRUE, 'America/New_York',    'CRM-3001'),
(3002, 'Emma Wilson',     'e.wilson@acme.com',          'end-user', NULL, 1001, '2024-02-01 10:00:00+00', TRUE, 'America/Chicago',     'CRM-3002'),
(3003, 'James Cooper',    'j.cooper@cascadetech.net',   'end-user', NULL, 1002, '2024-02-25 10:00:00+00', FALSE, 'America/Los_Angeles', 'CRM-3003'),
(3004, 'Lily Chen',       'l.chen@cascadetech.net',     'end-user', NULL, 1002, '2024-03-01 10:00:00+00', TRUE, 'Asia/Singapore',      'CRM-3004'),
(3005, 'Ahmed Al-Rashid', 'a.alrashid@echostartup.io',  'end-user', NULL, 1003, '2024-06-05 10:00:00+00', FALSE, 'Asia/Dubai',          'CRM-3005'),
(3006, 'Sofia Martinez',  's.martinez@echostartup.io',  'end-user', NULL, 1003, '2024-06-10 10:00:00+00', TRUE, 'Europe/Madrid',       'CRM-3006');

-- TICKETS (50 rows)
-- Groups:
--   A  (5001-5010): Standard human agent — TTFR naive = TTFR UI (no discrepancy)
--   B  (5011-5018): AI bot self-resolved
--   B2 (5019-5023): AI bot escalated to human agent
--   C  (5024-5033): Automation fires first — TTFR naive ≠ TTFR UI  ← key for Q2
--   D  (5034-5041): SLA breach — urgent/high with late first response
--   E  (5042-5047): Reassigned — First Touch Solve = false
--   F  (5048-5050): Still open or pending
INSERT INTO zendesk.tickets (id, external_id, created_at, updated_at, type, subject, priority, status, requester_id, submitter_id, assignee_id, organization_id, tags, satisfaction_rating) VALUES

-- Group A
(5001, NULL, '2025-01-10 09:00:00+00', '2025-01-10 17:00:00+00', 'problem',  'Cannot access dashboard after password reset',           'normal', 'closed', 3001, 3001, 2001, 1001, NULL, NULL),
(5002, NULL, '2025-01-13 10:30:00+00', '2025-01-13 18:30:00+00', 'incident', 'API rate limit errors blocking production deployment',    'high',   'closed', 3002, 3002, 2002, 1001, NULL, NULL),
(5003, NULL, '2025-01-15 08:45:00+00', '2025-01-15 16:45:00+00', 'question', 'How do I configure custom fields on ticket forms?',       'normal', 'closed', 3003, 3003, 2003, 1002, NULL, NULL),
(5004, NULL, '2025-01-17 14:00:00+00', '2025-01-17 22:00:00+00', 'task',     'Request to update billing contact email address',         'low',    'closed', 3004, 3004, 2004, 1002, NULL, NULL),
(5005, NULL, '2025-01-20 11:15:00+00', '2025-01-20 19:15:00+00', 'incident', 'Production data sync failing for 3 hours',               'urgent', 'closed', 3005, 3005, 2005, 1003, NULL, NULL),
(5006, NULL, '2025-01-22 09:30:00+00', '2025-01-22 17:30:00+00', 'problem',  'SSO login broken after domain migration',                'high',   'closed', 3006, 3006, 2001, 1003, NULL, NULL),
(5007, NULL, '2025-01-25 13:00:00+00', '2025-01-25 21:00:00+00', 'problem',  'Bulk CSV import failing with 500 error',                 'normal', 'closed', 3001, 3001, 2002, 1001, NULL, NULL),
(5008, NULL, '2025-01-27 10:00:00+00', '2025-01-27 18:00:00+00', 'question', 'Webhook events not firing for new subscriptions',         'normal', 'closed', 3002, 3002, 2003, 1001, NULL, NULL),
(5009, NULL, '2025-02-03 09:00:00+00', '2025-02-03 17:00:00+00', 'incident', 'Two-factor authentication emails not arriving',           'high',   'closed', 3003, 3003, 2004, 1002, NULL, NULL),
(5010, NULL, '2025-02-05 11:30:00+00', '2025-02-05 19:30:00+00', 'problem',  'User permissions not syncing correctly with directory',   'normal', 'closed', 3004, 3004, 2005, 1002, NULL, NULL),

-- Group B: AI bot self-resolved
(5011, NULL, '2025-02-01 09:00:00+00', '2025-02-01 11:00:00+00', 'question', 'How do I reset my two-factor authentication?',           'low',    'closed', 3001, 3001, 2011, 1001, NULL, NULL),
(5012, NULL, '2025-02-03 14:00:00+00', '2025-02-03 16:00:00+00', 'question', 'What is the difference between admin and agent roles?',  'low',    'closed', 3002, 3002, 2011, 1001, NULL, NULL),
(5013, NULL, '2025-02-05 10:30:00+00', '2025-02-05 12:30:00+00', 'question', 'Can I export my data in Excel format?',                  'low',    'closed', 3003, 3003, 2012, 1002, NULL, NULL),
(5014, NULL, '2025-02-07 09:00:00+00', '2025-02-07 11:00:00+00', 'question', 'How do I set up automated ticket routing rules?',        'normal', 'closed', 3004, 3004, 2012, 1002, NULL, NULL),
(5015, NULL, '2025-02-10 13:00:00+00', '2025-02-10 15:00:00+00', 'question', 'Where can I find the API documentation?',               'low',    'closed', 3005, 3005, 2013, 1003, NULL, NULL),
(5016, NULL, '2025-02-12 10:00:00+00', '2025-02-12 12:00:00+00', 'question', 'How do I enable email notifications for my team?',       'low',    'closed', 3006, 3006, 2013, 1003, NULL, NULL),
(5017, NULL, '2025-02-14 09:30:00+00', '2025-02-14 11:30:00+00', 'question', 'What file types can be attached to tickets?',            'low',    'closed', 3001, 3001, 2011, 1001, NULL, NULL),
(5018, NULL, '2025-02-17 14:00:00+00', '2025-02-17 16:00:00+00', 'question', 'How do I create a custom view in my dashboard?',         'normal', 'closed', 3002, 3002, 2012, 1001, NULL, NULL),

-- Group B2: AI bot escalated to human
(5019, NULL, '2025-03-10 09:30:00+00', '2025-03-10 14:30:00+00', 'problem',  'Bot could not resolve SSO login failure after update',   'high',   'solved', 3001, 3001, 2001, 1001, NULL, NULL),
(5020, NULL, '2025-03-12 14:00:00+00', '2025-03-12 19:00:00+00', 'problem',  'AI escalation: complex API configuration issue',         'normal', 'solved', 3003, 3003, 2003, 1002, NULL, NULL),
(5021, NULL, '2025-03-14 10:30:00+00', '2025-03-14 15:30:00+00', 'incident', 'Escalated: billing discrepancy requires human review',   'high',   'solved', 3004, 3004, 2002, 1002, NULL, NULL),
(5022, NULL, '2025-03-17 09:00:00+00', '2025-03-17 14:00:00+00', 'problem',  'Bot escalation: intermittent timeout errors unresolved', 'normal', 'solved', 3005, 3005, 2005, 1003, NULL, NULL),
(5023, NULL, '2025-03-19 13:00:00+00', '2025-03-19 18:00:00+00', 'problem',  'Escalated: GDPR data deletion needs human approval',     'high',   'solved', 3006, 3006, 2004, 1003, NULL, NULL),

-- Group C: Automation discrepancy — audit author_id=1 opens ticket before any agent touches it
(5024, NULL, '2025-03-10 09:00:00+00', '2025-03-10 14:00:00+00', 'task',     'New user onboarding access setup request',               'normal', 'solved', 3001, 3001, 2006, 1001, NULL, NULL),
(5025, NULL, '2025-03-11 10:00:00+00', '2025-03-11 15:00:00+00', 'incident', 'System alert: API error rate spike detected',             'high',   'solved', 3003, 3003, 2007, 1002, NULL, NULL),
(5026, NULL, '2025-03-12 14:00:00+00', '2025-03-12 19:00:00+00', 'task',     'Automated security scan flagged account configuration',   'normal', 'solved', 3005, 3005, 2008, 1003, NULL, NULL),
(5027, NULL, '2025-03-13 09:30:00+00', '2025-03-13 14:30:00+00', 'incident', 'Auto-detected: failed payment method on account',         'high',   'solved', 3002, 3002, 2006, 1001, NULL, NULL),
(5028, NULL, '2025-03-14 11:00:00+00', '2025-03-14 16:00:00+00', 'task',     'Trial expiry notification — upgrade assistance needed',   'normal', 'solved', 3004, 3004, 2009, 1002, NULL, NULL),
(5029, NULL, '2025-03-17 09:00:00+00', '2025-03-17 14:00:00+00', 'incident', 'System alert: account storage at 95% capacity',           'urgent', 'solved', 3006, 3006, 2010, 1003, NULL, NULL),
(5030, NULL, '2025-03-18 14:30:00+00', '2025-03-18 19:30:00+00', 'task',     'Scheduled maintenance window coordination required',      'normal', 'solved', 3001, 3001, 2007, 1001, NULL, NULL),
(5031, NULL, '2025-03-19 10:00:00+00', '2025-03-19 15:00:00+00', 'incident', 'Auto-escalation: SLA warning on long-running ticket',     'high',   'solved', 3003, 3003, 2008, 1002, NULL, NULL),
(5032, NULL, '2025-03-20 09:30:00+00', '2025-03-20 14:30:00+00', 'task',     'Auto-ticket: unusual login activity on account',          'normal', 'solved', 3005, 3005, 2009, 1003, NULL, NULL),
(5033, NULL, '2025-03-21 11:00:00+00', '2025-03-21 16:00:00+00', 'incident', 'Monitoring alert: webhook delivery failures detected',    'high',   'solved', 3002, 3002, 2010, 1001, NULL, NULL),

-- Group D: SLA breach — system auto-opens, then agent responds LATE
(5034, NULL, '2025-04-07 09:00:00+00', '2025-04-08 09:00:00+00', 'incident', 'Complete auth service outage — no users can log in',     'urgent', 'solved', 3005, 3005, 2001, 1003, NULL, NULL),
(5035, NULL, '2025-04-07 10:30:00+00', '2025-04-08 10:30:00+00', 'incident', 'Data corruption detected in production database',         'urgent', 'solved', 3001, 3001, 2002, 1001, NULL, NULL),
(5036, NULL, '2025-04-08 09:00:00+00', '2025-04-09 13:00:00+00', 'incident', 'Critical bug: incorrect billing amounts charged',         'high',   'solved', 3003, 3003, 2003, 1002, NULL, NULL),
(5037, NULL, '2025-04-08 14:00:00+00', '2025-04-09 14:00:00+00', 'incident', 'Security incident: unauthorized access attempt detected', 'urgent', 'solved', 3002, 3002, 2004, 1001, NULL, NULL),
(5038, NULL, '2025-04-09 09:30:00+00', '2025-04-10 13:30:00+00', 'incident', 'Major performance degradation — 30 second page loads',   'high',   'solved', 3004, 3004, 2005, 1002, NULL, NULL),
(5039, NULL, '2025-04-09 11:00:00+00', '2025-04-10 11:00:00+00', 'incident', 'Payment integration completely down for all users',       'urgent', 'solved', 3006, 3006, 2001, 1003, NULL, NULL),
(5040, NULL, '2025-04-10 09:00:00+00', '2025-04-11 13:00:00+00', 'incident', 'Critical API endpoints returning 401 for all users',     'high',   'solved', 3005, 3005, 2002, 1003, NULL, NULL),
(5041, NULL, '2025-04-10 14:30:00+00', '2025-04-11 14:30:00+00', 'incident', 'Emergency: data export service returning corrupted files','urgent', 'solved', 3001, 3001, 2003, 1001, NULL, NULL),

-- Group E: Reassigned — First Touch Solve = false (check for assignee_id Change events)
(5042, NULL, '2025-04-14 09:00:00+00', '2025-04-14 17:00:00+00', 'problem',  'Complex enterprise SFTP and API integration setup',      'high',   'solved', 3001, 3001, 2005, 1001, NULL, NULL),
(5043, NULL, '2025-04-15 10:30:00+00', '2025-04-15 18:30:00+00', 'task',     'Multi-org permission hierarchy configuration',           'normal', 'solved', 3003, 3003, 2003, 1002, NULL, NULL),
(5044, NULL, '2025-04-16 09:00:00+00', '2025-04-16 17:00:00+00', 'problem',  'Custom SLA rules setup for enterprise account',          'high',   'solved', 3005, 3005, 2004, 1003, NULL, NULL),
(5045, NULL, '2025-04-17 14:00:00+00', '2025-04-17 22:00:00+00', 'problem',  'Third-party analytics integration tracking incorrectly', 'normal', 'solved', 3002, 3002, 2002, 1001, NULL, NULL),
(5046, NULL, '2025-04-18 10:30:00+00', '2025-04-18 18:30:00+00', 'incident', 'Billing dispute from three months of overcharges',       'high',   'solved', 3006, 3006, 2001, 1003, NULL, NULL),
(5047, NULL, '2025-04-21 09:00:00+00', '2025-04-21 17:00:00+00', 'task',     'Compliance audit log extraction in custom format',       'normal', 'solved', 3004, 3004, 2005, 1002, NULL, NULL),

-- Group F: Open / pending — no resolution yet
(5048, NULL, '2025-05-05 09:00:00+00', '2025-05-07 09:00:00+00', 'problem',  'Intermittent login failures — hard to reproduce',        'high',   'open',    3001, 3001, 2006, 1001, NULL, NULL),
(5049, NULL, '2025-05-06 10:30:00+00', '2025-05-08 10:30:00+00', 'problem',  'API pagination returning inconsistent results since v3.2','normal', 'pending', 3003, 3003, 2007, 1002, NULL, NULL),
(5050, NULL, '2025-05-09 09:30:00+00', '2025-05-11 09:30:00+00', 'incident', 'Critical: user data not persisting after session timeout','urgent', 'open',    3005, 3005, 2008, 1003, NULL, NULL);

-- TICKET AUDITS (150 rows — 3 per ticket, IDs 6001–6150)
-- Key patterns:
--   Group A  : audit 1 author = agent (TTFR naive = TTFR UI — same event)
--   Group B  : audit 1 author = ai_bot
--   Group B2 : audit 1 = ai_bot opens, audit 2 = ai_bot reassigns to human
--   Group C  : audit 1 author = 1 (system trigger) ← naive TTFR = 3min
--              audit 2 author = agent (public comment) ← UI TTFR = 45min
--   Group D  : audit 1 author = 1 (system), audit 2 = LATE agent comment (SLA breach)
--   Group E  : audit 2 = assignee_id Change event (first agent → second agent)
--   Group F  : audit 3 = status → pending
INSERT INTO zendesk.ticket_audits (id, ticket_id, author_id, created_at, events) VALUES

-- ── Group A: agent opens + comments in same event (no discrepancy) ──
(6001, 5001, 2001, '2025-01-10 09:20:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6002, 5001, 2001, '2025-01-10 12:30:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6003, 5001, 2001, '2025-01-10 17:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6004, 5002, 2002, '2025-01-13 10:50:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6005, 5002, 2002, '2025-01-13 14:00:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6006, 5002, 2002, '2025-01-13 18:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6007, 5003, 2003, '2025-01-15 09:05:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6008, 5003, 2003, '2025-01-15 12:15:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6009, 5003, 2003, '2025-01-15 16:45:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6010, 5004, 2004, '2025-01-17 14:20:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6011, 5004, 2004, '2025-01-17 17:30:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6012, 5004, 2004, '2025-01-17 22:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6013, 5005, 2005, '2025-01-20 11:35:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6014, 5005, 2005, '2025-01-20 14:45:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6015, 5005, 2005, '2025-01-20 19:15:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6016, 5006, 2001, '2025-01-22 09:50:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6017, 5006, 2001, '2025-01-22 13:00:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6018, 5006, 2001, '2025-01-22 17:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6019, 5007, 2002, '2025-01-25 13:20:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6020, 5007, 2002, '2025-01-25 16:30:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6021, 5007, 2002, '2025-01-25 21:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6022, 5008, 2003, '2025-01-27 10:20:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6023, 5008, 2003, '2025-01-27 13:30:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6024, 5008, 2003, '2025-01-27 18:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6025, 5009, 2004, '2025-02-03 09:20:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6026, 5009, 2004, '2025-02-03 12:30:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6027, 5009, 2004, '2025-02-03 17:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

(6028, 5010, 2005, '2025-02-05 11:50:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am looking into this for you right now."}]'),
(6029, 5010, 2005, '2025-02-05 15:00:00+00', '[{"type":"Comment","public":false,"body":"Internal: investigating root cause, checking error logs."}]'),
(6030, 5010, 2005, '2025-02-05 19:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"This has been resolved. Please reopen if you need anything else."}]'),

-- ── Group B: AI bot self-resolved ──
(6031, 5011, 2011, '2025-02-01 09:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Aria, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6032, 5011, 3001, '2025-02-01 10:00:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6033, 5011, 2011, '2025-02-01 11:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

(6034, 5012, 2011, '2025-02-03 14:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Aria, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6035, 5012, 3002, '2025-02-03 15:00:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6036, 5012, 2011, '2025-02-03 16:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

(6037, 5013, 2012, '2025-02-05 10:32:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Zara, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6038, 5013, 3003, '2025-02-05 11:30:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6039, 5013, 2012, '2025-02-05 12:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

(6040, 5014, 2012, '2025-02-07 09:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Zara, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6041, 5014, 3004, '2025-02-07 10:00:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6042, 5014, 2012, '2025-02-07 11:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

(6043, 5015, 2013, '2025-02-10 13:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Max, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6044, 5015, 3005, '2025-02-10 14:00:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6045, 5015, 2013, '2025-02-10 15:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

(6046, 5016, 2013, '2025-02-12 10:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Max, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6047, 5016, 3006, '2025-02-12 11:00:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6048, 5016, 2013, '2025-02-12 12:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

(6049, 5017, 2011, '2025-02-14 09:32:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Aria, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6050, 5017, 3001, '2025-02-14 10:30:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6051, 5017, 2011, '2025-02-14 11:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

(6052, 5018, 2012, '2025-02-17 14:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Zara, your AI support assistant. I have reviewed your question and can help right away."}]'),
(6053, 5018, 3002, '2025-02-17 15:00:00+00', '[{"type":"Comment","public":true,"body":"Thanks, that worked! Appreciate the quick response."}]'),
(6054, 5018, 2012, '2025-02-17 16:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Marking as solved. Feel free to reopen if needed!"}]'),

-- ── Group B2: AI bot escalated to human ──
(6055, 5019, 2011, '2025-03-10 09:32:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Aria, your AI support assistant. Let me take a look at this for you."}]'),
(6056, 5019, 2011, '2025-03-10 10:02:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2011,"value":2001},{"type":"Comment","public":false,"body":"AI: escalating to human agent — issue outside my resolution scope."}]'),
(6057, 5019, 2001, '2025-03-10 14:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have resolved the issue. Let me know if you need anything else."}]'),

(6058, 5020, 2012, '2025-03-12 14:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Zara, your AI support assistant. Let me take a look at this for you."}]'),
(6059, 5020, 2012, '2025-03-12 14:32:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2012,"value":2003},{"type":"Comment","public":false,"body":"AI: escalating to human agent — issue outside my resolution scope."}]'),
(6060, 5020, 2003, '2025-03-12 19:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have resolved the issue. Let me know if you need anything else."}]'),

(6061, 5021, 2011, '2025-03-14 10:32:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Aria, your AI support assistant. Let me take a look at this for you."}]'),
(6062, 5021, 2011, '2025-03-14 11:02:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2011,"value":2002},{"type":"Comment","public":false,"body":"AI: escalating to human agent — issue outside my resolution scope."}]'),
(6063, 5021, 2002, '2025-03-14 15:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have resolved the issue. Let me know if you need anything else."}]'),

(6064, 5022, 2013, '2025-03-17 09:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Max, your AI support assistant. Let me take a look at this for you."}]'),
(6065, 5022, 2013, '2025-03-17 09:32:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2013,"value":2005},{"type":"Comment","public":false,"body":"AI: escalating to human agent — issue outside my resolution scope."}]'),
(6066, 5022, 2005, '2025-03-17 14:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have resolved the issue. Let me know if you need anything else."}]'),

(6067, 5023, 2012, '2025-03-19 13:02:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hi! I am Zara, your AI support assistant. Let me take a look at this for you."}]'),
(6068, 5023, 2012, '2025-03-19 13:32:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2012,"value":2004},{"type":"Comment","public":false,"body":"AI: escalating to human agent — issue outside my resolution scope."}]'),
(6069, 5023, 2004, '2025-03-19 18:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have resolved the issue. Let me know if you need anything else."}]'),

-- ── Group C: Automation discrepancy ──
-- audit 1: author=1 (system trigger) opens ticket  → TTFR naive = ~3 min
-- audit 2: author=agent (first PUBLIC comment)      → TTFR UI   = ~45 min
(6070, 5024, 1,    '2025-03-10 09:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6071, 5024, 2006, '2025-03-10 09:45:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6072, 5024, 2006, '2025-03-10 14:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6073, 5025, 1,    '2025-03-11 10:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6074, 5025, 2007, '2025-03-11 10:45:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6075, 5025, 2007, '2025-03-11 15:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6076, 5026, 1,    '2025-03-12 14:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6077, 5026, 2008, '2025-03-12 14:45:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6078, 5026, 2008, '2025-03-12 19:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6079, 5027, 1,    '2025-03-13 09:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6080, 5027, 2006, '2025-03-13 10:15:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6081, 5027, 2006, '2025-03-13 14:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6082, 5028, 1,    '2025-03-14 11:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6083, 5028, 2009, '2025-03-14 11:45:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6084, 5028, 2009, '2025-03-14 16:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6085, 5029, 1,    '2025-03-17 09:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6086, 5029, 2010, '2025-03-17 09:45:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6087, 5029, 2010, '2025-03-17 14:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6088, 5030, 1,    '2025-03-18 14:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6089, 5030, 2007, '2025-03-18 15:15:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6090, 5030, 2007, '2025-03-18 19:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6091, 5031, 1,    '2025-03-19 10:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6092, 5031, 2008, '2025-03-19 10:45:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6093, 5031, 2008, '2025-03-19 15:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6094, 5032, 1,    '2025-03-20 09:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6095, 5032, 2009, '2025-03-20 10:15:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6096, 5032, 2009, '2025-03-20 14:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

(6097, 5033, 1,    '2025-03-21 11:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6098, 5033, 2010, '2025-03-21 11:45:00+00', '[{"type":"Comment","public":true,"body":"Hi, I have picked up your ticket and am reviewing the details now."}]'),
(6099, 5033, 2010, '2025-03-21 16:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"All resolved now. Thanks for your patience."}]'),

-- ── Group D: SLA breach — system auto-opens, agent responds LATE ──
-- urgent SLA = 1h  → agent responds at T+5h  (breaches by 4h)
-- high   SLA = 4h  → agent responds at T+8h  (breaches by 4h)
(6100, 5034, 1,    '2025-04-07 09:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6101, 5034, 2001, '2025-04-07 14:00:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6102, 5034, 2001, '2025-04-08 09:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

(6103, 5035, 1,    '2025-04-07 10:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6104, 5035, 2002, '2025-04-07 15:30:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6105, 5035, 2002, '2025-04-08 10:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

(6106, 5036, 1,    '2025-04-08 09:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6107, 5036, 2003, '2025-04-08 17:00:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6108, 5036, 2003, '2025-04-09 13:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

(6109, 5037, 1,    '2025-04-08 14:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6110, 5037, 2004, '2025-04-08 19:00:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6111, 5037, 2004, '2025-04-09 14:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

(6112, 5038, 1,    '2025-04-09 09:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6113, 5038, 2005, '2025-04-09 17:30:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6114, 5038, 2005, '2025-04-10 13:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

(6115, 5039, 1,    '2025-04-09 11:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6116, 5039, 2001, '2025-04-09 16:00:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6117, 5039, 2001, '2025-04-10 11:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

(6118, 5040, 1,    '2025-04-10 09:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6119, 5040, 2002, '2025-04-10 17:00:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6120, 5040, 2002, '2025-04-11 13:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

(6121, 5041, 1,    '2025-04-10 14:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6122, 5041, 2003, '2025-04-10 19:30:00+00', '[{"type":"Comment","public":true,"body":"Apologies for the delayed response. I am now investigating this issue as a top priority."}]'),
(6123, 5041, 2003, '2025-04-11 14:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"Resolved. A post-incident review will follow. Apologies for the impact."}]'),

-- ── Group E: Reassigned — audit 2 contains assignee_id Change event ──
(6124, 5042, 2001, '2025-04-14 09:15:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hello! I am looking into this now and will update you shortly."}]'),
(6125, 5042, 2001, '2025-04-14 11:00:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2001,"value":2005}]'),
(6126, 5042, 2005, '2025-04-14 17:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have taken over this ticket and resolved the issue. Thank you for your patience."}]'),

(6127, 5043, 2002, '2025-04-15 10:45:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hello! I am looking into this now and will update you shortly."}]'),
(6128, 5043, 2002, '2025-04-15 12:30:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2002,"value":2003}]'),
(6129, 5043, 2003, '2025-04-15 18:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have taken over this ticket and resolved the issue. Thank you for your patience."}]'),

(6130, 5044, 2001, '2025-04-16 09:15:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hello! I am looking into this now and will update you shortly."}]'),
(6131, 5044, 2001, '2025-04-16 11:00:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2001,"value":2004}]'),
(6132, 5044, 2004, '2025-04-16 17:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have taken over this ticket and resolved the issue. Thank you for your patience."}]'),

(6133, 5045, 2003, '2025-04-17 14:15:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hello! I am looking into this now and will update you shortly."}]'),
(6134, 5045, 2003, '2025-04-17 16:00:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2003,"value":2002}]'),
(6135, 5045, 2002, '2025-04-17 22:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have taken over this ticket and resolved the issue. Thank you for your patience."}]'),

(6136, 5046, 2004, '2025-04-18 10:45:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hello! I am looking into this now and will update you shortly."}]'),
(6137, 5046, 2004, '2025-04-18 12:30:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2004,"value":2001}]'),
(6138, 5046, 2001, '2025-04-18 18:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have taken over this ticket and resolved the issue. Thank you for your patience."}]'),

(6139, 5047, 2002, '2025-04-21 09:15:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open"},{"type":"Comment","public":true,"body":"Hello! I am looking into this now and will update you shortly."}]'),
(6140, 5047, 2002, '2025-04-21 11:00:00+00', '[{"type":"Change","field_name":"assignee_id","previous_value":2002,"value":2005}]'),
(6141, 5047, 2005, '2025-04-21 17:00:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"solved"},{"type":"Comment","public":true,"body":"I have taken over this ticket and resolved the issue. Thank you for your patience."}]'),

-- ── Group F: Open / pending — no resolution ──
(6142, 5048, 1,    '2025-05-05 09:03:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6143, 5048, 2006, '2025-05-05 10:00:00+00', '[{"type":"Comment","public":true,"body":"Hi, I am looking into this and will update you shortly."}]'),
(6144, 5048, 2006, '2025-05-07 09:00:00+00', '[{"type":"Comment","public":false,"body":"Internal: still investigating, unable to reproduce consistently."}]'),

(6145, 5049, 1,    '2025-05-06 10:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6146, 5049, 2007, '2025-05-06 11:30:00+00', '[{"type":"Comment","public":true,"body":"Hi, I am looking into this and will update you shortly."}]'),
(6147, 5049, 2007, '2025-05-08 10:30:00+00', '[{"type":"Change","field_name":"status","previous_value":"open","value":"pending"},{"type":"Comment","public":true,"body":"I need some additional information to proceed. Could you please share the full error log?"}]'),

(6148, 5050, 1,    '2025-05-09 09:33:00+00', '[{"type":"Change","field_name":"status","previous_value":"new","value":"open","via":{"channel":"rule","source":{"rel":"trigger"}}}]'),
(6149, 5050, 2008, '2025-05-09 10:30:00+00', '[{"type":"Comment","public":true,"body":"Hi, I am looking into this and will update you shortly."}]'),
(6150, 5050, 2008, '2025-05-11 09:30:00+00', '[{"type":"Comment","public":false,"body":"Internal: critical issue, looping in on-call engineer."}]');
