# /ship

Prepare the current work for shipping: review, test, and produce a PR.

## Steps

1. Run `/review` — fix any blocking issues.
2. Run `/test` — confirm tests pass.
3. Check `git status` — ensure nothing unstaged.
4. Write a commit message: one-line summary + body if needed; co-authored by Claude.
5. Produce a PR description with: Summary (bullets), Test plan (checklist), any breaking changes.
6. Confirm with user before pushing or creating the PR.

## Constraints

- Never force-push to main.
- Never skip hooks (`--no-verify`).
- Never amend a published commit.
- Always confirm before push/PR creation.

## Output

Commit message + PR body, ready to paste or execute.
