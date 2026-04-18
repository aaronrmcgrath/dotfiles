---
name: ai-config
version: "2.0"
description: Vendor-neutral AI assistant configuration base layer
author: Aaron McGrath
tracked: dotfiles bare repo
sources:
  - user.md
  - machine.md
  - skills/domains/
  - agents/
  - commands/
generated:
  - ~/AGENTS.md
  - ~/.claude/skills/*/SKILL.md
---

# AI Config — Global Base Layer

This directory (`~/.ai/`) is the single source of truth for AI assistant configuration across all vendors and tools. It is tracked in the dotfiles bare repo alongside `.config/nvim/` and other portable configs.

## Design Principles

1. **Vendor-neutral source** — all content here is plain markdown organized by purpose, not by vendor.
2. **Minimal compile surface** — Claude consumes via native `@`-imports and symlinks; other vendors get a concatenated `~/AGENTS.md`. We don't pre-pay for formats that don't exist yet.
3. **Layered** — system (`machine.md`) + user (`user.md`) form the base. Projects add on top via `<project>/.ai/`.
4. **Idempotent** — `init-machine` and `compile-ai-config` are safe to re-run at any time.

## Layer Map

| File | Mechanism | Consumer |
|---|---|---|
| `user.md` | `@`-import in CLAUDE.md | Claude Code |
| `machine.md` | `@`-import in CLAUDE.md | Claude Code |
| `init.md` | `@`-import in CLAUDE.md | Claude Code |
| `skills/domains/*.md` | compiled → `SKILL.md` | Claude Code (progressive) |
| `agents/*.md` | symlinked → `~/.claude/agents/` | Claude Code |
| `commands/*.md` | symlinked → `~/.claude/commands/` | Claude Code |
| `user.md` + `machine.md` + others | concatenated → `~/AGENTS.md` | All other vendors |

## Extending

- Add a domain skill: drop a `.md` in `skills/domains/`, recompile.
- Add an agent: write `agents/<name>.md`, re-run symlink step.
- Add a vendor target: add a compile case in `bin/compile-ai-config`.
- Per-project overrides: `<project>/.ai/` + `<project>/.claude/CLAUDE.md`.
