# /test

Write and run tests for the current task or specified code.

## Steps

1. Identify what needs testing (current diff, specified file, or explicit description).
2. Read the code under test.
3. Delegate to the `tester` agent to write tests.
4. Run the test suite; report results.
5. Flag any remaining coverage gaps.

## Options

- `/test unit` — unit tests only
- `/test feature` — feature/integration tests only
- `/test [file or function]` — test a specific target
- `/test coverage` — analyze existing coverage and identify gaps

## Defaults

- Tests must pass before reporting done.
- No test stubs or skipped tests in the output.
- Real database, no mocking the DB layer.
