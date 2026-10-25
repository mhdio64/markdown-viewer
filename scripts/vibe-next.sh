#!/usr/bin/env bash
set -euo pipefail

# Close a ticket already implemented and approved in an independent review.
# Run only from the Git repository root, on the ticket feature branch.
usage() {
    printf 'Usage: %s TICKET-001-slug --approve [--next TICKET-002-slug]\n' "$0" >&2
    exit 2
}
[[ $# == 2 || $# == 4 ]] || usage
TICKET="$1"
[[ "$2" == "--approve" ]] || usage
[[ "$TICKET" =~ ^TICKET-[0-9]{3,}(-[a-z0-9]+)*$ ]] || usage
NEXT="None"
if [[ $# == 4 ]]; then
    [[ "$3" == '--next' ]] || usage
    NEXT="$4"
    [[ "$NEXT" =~ ^TICKET-[0-9]{3,}(-[a-z0-9]+)*$ ]] || usage
fi

fail() { printf 'ERROR: %s\n' "$*" >&2; exit 1; }
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail 'not inside a Git working tree'
[[ "$(cd -- "$(git rev-parse --show-toplevel)" && pwd -P)" == "$(pwd -P)" ]] || fail 'run from Git root'
BRANCH="$(git branch --show-current)"
[[ -n "$BRANCH" && "$BRANCH" != 'main' && "$BRANCH" != 'master' ]] || fail 'run on a non-default feature branch'

SRC="docs/tickets/review/$TICKET.md"
DEST="docs/tickets/done/$TICKET.md"
REPORT="docs/reviews/$TICKET.md"
[[ -f "$SRC" && ! -L "$SRC" ]] || fail "review ticket missing: $SRC"
[[ ! -e "$DEST" && ! -L "$DEST" ]] || fail "destination exists: $DEST"
[[ -f "$REPORT" && ! -L "$REPORT" ]] || fail "review report missing: $REPORT"
[[ -f HANDOFF.md && ! -L HANDOFF.md ]] || fail 'HANDOFF.md missing'
if [[ "$NEXT" != 'None' ]]; then
    [[ -f "docs/tickets/todo/$NEXT.md" && ! -L "docs/tickets/todo/$NEXT.md" ]] || fail 'requested next ticket is not in todo'
fi

HEAD_SHA="$(git rev-parse HEAD)"
grep -Fxq -- 'Verdict: APPROVED' "$REPORT" || fail 'review verdict is not APPROVED'
grep -Fxq -- "Reviewed-Commit: $HEAD_SHA" "$REPORT" || fail 'reviewed commit does not match HEAD'
grep -Fxq -- "- Active Ticket: $TICKET" HANDOFF.md || fail 'HANDOFF active ticket does not match'
grep -Fxq -- '- Stage: review' HANDOFF.md || fail 'HANDOFF stage must be review'
for key in '- Last Completed:' '- Next Ticket:'; do
    grep -Fq -- "$key" HANDOFF.md || fail "HANDOFF key missing: $key"
done

# The only permitted dirty file is the newly created review report.
# This prevents accidentally committing unrelated source edits or secrets.
STATUS="$(git status --porcelain --untracked-files=all)"
EXPECTED="?? $REPORT"
[[ "$STATUS" == "$EXPECTED" ]] || fail "unexpected dirty files or staged changes; actual: [$STATUS]; expected only: [$EXPECTED]"

# Independently re-run configured commands before modifying ticket state.
[[ -f scripts/vibe-verify.py && ! -L scripts/vibe-verify.py ]] || fail 'verification runner missing'
python3 scripts/vibe-verify.py || fail 'project verification gate failed'
[[ "$(git rev-parse HEAD)" == "$HEAD_SHA" ]] || fail 'verification modified the reviewed commit'
[[ "$(git status --porcelain --untracked-files=all)" == "$EXPECTED" ]] || fail 'verification changed the worktree; review changes before closing'

git mv -- "$SRC" "$DEST"
# These keys have an exact, documented single-line format in the template.
sed -i \
    -e 's/^- Active Ticket: .*/- Active Ticket: None/' \
    -e 's/^- Stage: .*/- Stage: ready/' \
    -e "s/^- Last Completed: .*/- Last Completed: $TICKET/" \
    -e "s/^- Next Ticket: .*/- Next Ticket: $NEXT/" HANDOFF.md

git add -- HANDOFF.md "$REPORT"
git diff --cached --check || fail 'staged whitespace/conflict checks failed'
git commit -m "chore(tickets): approve and close $TICKET"

printf '\nCLOSED: %s\n' "$TICKET"
if [[ "$NEXT" == 'None' ]]; then
    printf 'No next ticket was selected. Select an unblocked ticket manually.\n'
else
    PROMPT="Read CONSTITUTION.md, HANDOFF.md, and docs/tickets/todo/$NEXT.md. Verify its blockers are resolved, move it to active, record the base commit, and implement only its acceptance criteria. Stop for review."
    printf '\nNext-session prompt:\n%s\n' "$PROMPT"
    if command -v wl-copy >/dev/null 2>&1; then
        printf %s "$PROMPT" | wl-copy || true
    elif command -v xclip >/dev/null 2>&1; then
        printf %s "$PROMPT" | xclip -selection clipboard || true
    elif command -v pbcopy >/dev/null 2>&1; then
        printf %s "$PROMPT" | pbcopy || true
    fi
fi
