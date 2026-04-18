# /review

Review the current branch's changes (or a specified PR) for correctness, security, and quality.

## Steps

1. Run `git diff main...HEAD` (or `git diff` if on main).
2. Pass the diff to the `code-reviewer` agent.
3. Pass the diff to the `security-reviewer` agent.
4. Synthesize findings: Blocking → Non-blocking → Nit → Security.
5. Report a clear go/no-go recommendation.

## Options

- `/review security` — security-only pass
- `/review [PR number or branch]` — review a specific branch or PR
- `/review quick` — blocking issues only, skip nits

## Output Format

```
## Review: [branch / description]

### Blocking
...

### Non-blocking
...

### Security
...

### Verdict
[ ] Ready to merge  [ ] Needs changes
```
