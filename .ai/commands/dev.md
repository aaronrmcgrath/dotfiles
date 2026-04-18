# /dev

Start a development session on the current codebase.

## Steps

1. Read `CLAUDE.md` (if present) and understand the project structure.
2. Check `git status` — note any uncommitted changes.
3. Identify the primary language and framework in use.
4. Ask: "What are you working on?" if no specific task is provided.
5. When given a task: delegate to the `programmer` agent for implementation, `tester` for test coverage.

## Defaults

- Always read relevant files before editing.
- Never modify files outside the scope of the stated task.
- Run the test suite if one exists before reporting done.
- Report what changed and where — brief, not verbose.
