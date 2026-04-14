# Optro Support Analytics — Data Engineer Interview

Welcome! This repo contains a synthetic Zendesk-like dataset for your interview.

## Setup (~5 minutes)

Run the two SQL files against any SQL database (PostgreSQL, DuckDB, SQLite, etc.).

**PostgreSQL**
```bash
psql -d your_database -f setup/schema.sql
psql -d your_database -f setup/seed.sql
```

**DuckDB**
```sql
.read setup/schema.sql
.read setup/seed.sql
```

**SQLite** — schema.sql uses `JSONB`; swap to `TEXT` if needed.

## What's in the repo

| Path | Description |
|------|-------------|
| `setup/schema.sql` | Table DDL — read this first |
| `setup/seed.sql` | ~1000 rows of synthetic support data |
| `brief/task.md` | Your task — start here after setup |
| `brief/vibe_coded_model.sql` | A SQL model a colleague shared — you'll use this later |

## Tables at a glance

| Table | Rows | Description |
|-------|------|-------------|
| `zendesk.organizations` | 5 | Customer companies |
| `zendesk.users` | 30 | Admins, agents (human + AI), end-users |
| `zendesk.tickets` | 100 | Support tickets |
| `zendesk.ticket_audits` | 500 | All ticket events as JSONB |
| `zendesk.ticket_fields` | 200 | Custom attributes per ticket |

> **Tip:** The `ticket_audits.events` column is a JSONB array. Each element is either a `"Change"` event (status, assignee) or a `"Comment"` event (public or private). This is where most of the interesting logic lives.
