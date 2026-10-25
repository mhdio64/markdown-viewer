---
trigger: model_decision
description: "Use for long terminal logs, large documentation responses, browser snapshots, and context optimization."
---
# Context Optimization

- Summarize large non-sensitive tool outputs only when the precise evidence remains accessible.
- Prefer targeted filtering over copying full dumps into chat.
- Context Mode is optional, MCP-only, and must not become the source of truth for tickets.
- Never pass credentials, identifiable personal records, or confidential data to Context Mode.
- On debugging/review, inspect complete relevant trace segments when summaries hide necessary details.
