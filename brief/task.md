# Support Analytics — Stakeholder Brief

## Context

Our VP of Support, Taylor Reyes, is presenting to the new executive team next week.
She needs a clear view of **agent performance** across our support team.

---

## The Ask

Taylor sent this in Slack:

> "Hey — I need a performance report for our support agents.
> Can we get something that shows how fast agents are responding and whether
> we're hitting our SLAs? I want to see individual agent breakdowns.
> We also just brought on some AI bots to handle tier-1 volume —
> I want to understand how they're performing compared to human agents."

---

## Your Task

Build a SQL model that produces an **agent performance summary**.

Taylor mentioned these areas of interest:
- How fast agents respond (TTFR)
- How long it takes to fully resolve tickets (Full Resolution Time)
- Whether agents solve tickets in a single touch (First Touch Solve)
- Whether we are meeting SLAs

Your output should be **aggregated by agent**, and clearly separate **human agents from AI bots**.

---

## Notes on the data

- `ticket_audits.events` is a JSONB array — each element is one event at that moment in time
- Events can be `"Change"` (status, assignee, priority) or `"Comment"` (public or private)
- Not all tickets have been resolved yet
- Ask clarifying questions if anything is ambiguous — treat this like a real stakeholder conversation

---

*The second part of the task will be introduced during the session.*
