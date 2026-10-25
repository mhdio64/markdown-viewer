---
trigger: model_decision
description: "Apply testing and quality guidance when implementing or reviewing source changes."
---
# Verification Discipline

1. Identify the approved acceptance criteria before implementation.
2. Use TDD when it produces meaningful behavioral evidence.
3. Run relevant focused tests and then agreed full checks.
4. Record exact command, exit status, and commit ID.
5. Never replace failing tests with superficial assertions or disable checks to obtain green output.
6. If a check is unavailable, mark it as not verified and block ticket closure.
