CREATE SCHEMA IF NOT EXISTS zendesk;

-- 1. Infrastructure: Organizations & Brands
CREATE TABLE zendesk.organizations (
    id              BIGINT PRIMARY KEY,
    name            TEXT NOT NULL,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    domain_names    JSONB,
    tags            JSONB,
    notes           TEXT
);

-- 2. People: Agents and Customers
--    agent_type is only populated when role = 'agent'
--    Use this to distinguish AI bots from human agents
CREATE TABLE zendesk.users (
    id              BIGINT PRIMARY KEY,
    name            TEXT NOT NULL,
    email           TEXT UNIQUE,
    role            TEXT CHECK (role IN ('admin', 'agent', 'end-user')),
    agent_type      TEXT CHECK (agent_type IN ('human', 'ai_bot')),
    organization_id BIGINT REFERENCES zendesk.organizations(id),
    created_at      TIMESTAMP WITH TIME ZONE,
    active          BOOLEAN DEFAULT TRUE,
    time_zone       TEXT,
    external_id     TEXT
);

-- 3. The Core: Tickets
CREATE TABLE zendesk.tickets (
    id                  BIGINT PRIMARY KEY,
    external_id         TEXT,
    created_at          TIMESTAMP WITH TIME ZONE,
    updated_at          TIMESTAMP WITH TIME ZONE,
    type                TEXT CHECK (type IN ('problem', 'incident', 'question', 'task')),
    subject             TEXT,
    priority            TEXT CHECK (priority IN ('urgent', 'high', 'normal', 'low')),
    status              TEXT CHECK (status IN ('new', 'open', 'pending', 'hold', 'solved', 'closed')),
    requester_id        BIGINT REFERENCES zendesk.users(id),
    submitter_id        BIGINT REFERENCES zendesk.users(id),
    assignee_id         BIGINT REFERENCES zendesk.users(id),
    organization_id     BIGINT REFERENCES zendesk.organizations(id),
    tags                JSONB,
    satisfaction_rating JSONB
);

-- 4. The Event Stream: Audits
--    Each row is a moment in time on a ticket.
--    events JSONB is an array — each element is either:
--      { "type": "Change",  "field_name": "status", "previous_value": "new", "value": "open" }
--      { "type": "Comment", "public": true/false, "body": "..." }
--      { "type": "Change",  "field_name": "assignee_id", "previous_value": 2001, "value": 2003 }
--    Automated system events (triggers/macros) are authored by user id = 1 (Zendesk System)
CREATE TABLE zendesk.ticket_audits (
    id          BIGINT PRIMARY KEY,
    ticket_id   BIGINT REFERENCES zendesk.tickets(id),
    author_id   BIGINT REFERENCES zendesk.users(id),
    created_at  TIMESTAMP WITH TIME ZONE,
    events      JSONB
);

-- 5. Custom Attributes: Ticket Fields
--    field_id 9001 = product_module  (e.g. 'Authentication', 'API', 'Billing', 'Reporting', 'Dashboard', 'Integration')
--    field_id 9002 = churn_risk      (e.g. 'high', 'medium', 'low')
CREATE TABLE zendesk.ticket_fields (
    id          BIGINT PRIMARY KEY,
    ticket_id   BIGINT REFERENCES zendesk.tickets(id),
    field_id    BIGINT,
    value       TEXT,
    updated_at  TIMESTAMP WITH TIME ZONE
);
