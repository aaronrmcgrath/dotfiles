# /plan

Produce an implementation plan for a feature or task before writing any code.

## Steps

1. Restate the goal in one sentence.
2. Identify all layers that will be touched (DB, models, API, UI, tests, config).
3. Sequence the work — dependencies first, parallelizable work flagged.
4. Identify risks: performance, security, backwards compatibility, migration safety.
5. Define done: what does correct look like? How will it be tested?

## Output

Produce a plan in the format defined by the `feature-planner` agent. Do not write code. Hand the plan to the user for approval before proceeding.

## When to use

- New feature spanning multiple layers
- Significant refactor
- Anything where the approach is non-obvious
