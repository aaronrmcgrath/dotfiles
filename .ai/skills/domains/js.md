# JavaScript / TypeScript Development

## Runtimes & Bundlers

- **Node.js** for server-side; **Vite** as the default bundler/dev server.
- **Bun** acceptable where speed matters and compatibility is not a concern.
- ESM modules by default; CJS only for legacy compatibility.

## Frontend

- **React** is the primary UI library. Functional components only; no class components.
- Prefer built-in React state (`useState`, `useReducer`) for local state.
- Use context sparingly; reach for Zustand or Jotai for non-trivial global state.
- CSS: Tailwind CSS is preferred. CSS Modules for component-scoped styles when needed.
- No jQuery, no Bootstrap (unless project already uses them).

## TypeScript

- Strict mode enabled (`"strict": true` in tsconfig).
- Avoid `any`; use `unknown` + type guards when type is truly unknown.
- Prefer `interface` for object shapes, `type` for unions/intersections.
- Zod for runtime validation at API/form boundaries.

## Package Management

- **pnpm** preferred for new projects (workspace support, disk efficiency).
- npm acceptable; yarn only for legacy projects.
- Lock file always committed.

## Conventions

- File naming: `kebab-case` for files, `PascalCase` for React components.
- Named exports preferred over default exports (except page-level components).
- No barrel re-exports that obscure tree-shaking.
- Async/await over raw Promises; explicit error handling.

## Tooling

- **ESLint** + **Prettier** for lint/format.
- **Vitest** for unit tests; **Playwright** for E2E.
- Path aliases configured in `vite.config.ts` and `tsconfig.json`.
