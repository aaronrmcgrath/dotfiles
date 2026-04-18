# PHP & Laravel Development

## Framework

- **Laravel** is the default framework. Use Laravel idioms; don't fight the framework.
- Prefer Eloquent for DB access. Raw queries only when Eloquent produces N+1 or bloated SQL.
- Use Laravel's built-in auth, queues, events, notifications, mail — don't reinvent them.
- Service providers and container bindings are fine; facades are acceptable.

## Testing

- **Pest** is preferred over PHPUnit directly (uses PHPUnit under the hood).
- Tests live in `tests/Feature/` (HTTP/integration) and `tests/Unit/` (pure logic).
- Use `RefreshDatabase` or `LazilyRefreshDatabase` for DB tests.
- Factory-first for test data; seeders are for dev/staging, not tests.
- No mocking the database — test against a real SQLite or MySQL test DB.

## Conventions

- PHP 8.2+ features are fair game: enums, readonly properties, match expressions, named args.
- Strict types (`declare(strict_types=1)`) in all new files.
- Type-hint everything; no `mixed` unless unavoidable.
- PSR-12 formatting; Laravel Pint as the formatter.
- Class names: PascalCase. Methods/variables: camelCase. DB columns: snake_case.

## Common Packages

- `spatie/laravel-permission` — roles/permissions
- `spatie/laravel-query-builder` — filterable/sortable API resources
- `barryvdh/laravel-debugbar` — local debug only
- `laravel/sanctum` or `laravel/passport` — API auth
- `laravel/horizon` — queue monitoring

## Anti-Patterns to Avoid

- Logic in controllers (move to actions, services, or jobs)
- Fat models (extract query scopes and business logic)
- Hardcoded config values (use `config()` and `.env`)
- Skipping validation (always validate at the boundary)
