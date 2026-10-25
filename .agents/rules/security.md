---
trigger: model_decision
description: "Apply security rules when handling auth, secrets, dependencies, databases, network access, CI/CD, or deployment."
---
# Security and Permission Rules

1. Use least-privilege tokens and read-only MCP access by default.
2. Never send secrets, patient data, or production logs to unapproved tools or third-party services.
3. Require approval for data deletion, package installation, privileges, Git publication, and deployment.
4. Treat Semgrep and Trivy findings as evidence to triage, not proof of comprehensive security.
5. Avoid disabling Antigravity's Default or Request Review permission controls.
