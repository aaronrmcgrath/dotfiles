# Dotfiles

My personal dotfiles managed using a bare Git repository. This approach keeps configuration files in their proper locations without symlinks.

## Table of Contents

- [Quick Start](#quick-start)
- [Prerequisites](#prerequisites)
- [Initial Setup (First Time)](#initial-setup-first-time)
- [Setting Up on a New Machine](#setting-up-on-a-new-machine)
- [Syncing an Existing Machine](#syncing-an-existing-machine)
- [Sharing Changes](#sharing-changes)
- [Daily Usage](#daily-usage)
- [Adding Files and Directories](#adding-files-and-directories)
- [AI Config Layer](#ai-config-layer)
- [Important Notes](#important-notes)
- [Troubleshooting](#troubleshooting)

## Quick Start

This dotfiles setup uses a **bare Git repository** with your home directory as the work tree. No symlinks required!

**Key concept:** The `dotfiles` command is an alias that works exactly like `git`, but manages files in your home directory using a hidden `.dotfiles` repository.

## Prerequisites

Install these before setting up on a new machine.

### Shell & core tools

> **macOS:**
> ```bash
> brew install git tmux fzf fortune
> ```

> **Linux (Ubuntu/Pop!_OS):**
> ```bash
> sudo apt install -y git zsh tmux fzf fortune-mod python3-venv
> ```

### Neovim

> **macOS:** `brew install neovim` (stays current)

> **Linux:** `apt install neovim` gives v0.9.5 — too old. Install via AppImage instead:
> ```bash
> curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
> chmod u+x nvim-linux-x86_64.appimage
> sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
> ```

### Node (via nvm)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
nvm install --lts
```

> **Linux:** If you use nvim plugins with build steps (e.g. `markdown-preview.nvim`), symlink node/npm system-wide so nvim's non-interactive build runner can find them:
> ```bash
> NODE_BIN="$(nvm which current)"
> sudo ln -sf "$NODE_BIN" /usr/local/bin/node
> sudo ln -sf "$(dirname $NODE_BIN)/npm" /usr/local/bin/npm
> ```

### Oh My Zsh

```bash
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

> **Important:** The oh-my-zsh installer overwrites `~/.zshrc`. Re-checkout your dotfiles version immediately after:
> ```bash
> dotfiles checkout -- .zshrc
> ```

### Nerd Font

Download [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases) and install:

> **macOS:** `brew install --cask font-jetbrains-mono-nerd-font`

> **Linux:** Extract to `~/.local/share/fonts/` then run `fc-cache -fv`. Verify with `fc-list | grep -i jetbrains` — the registered family name is `JetBrainsMono Nerd Font`. Use this exact string in `alacritty.toml`.

### pipx + mempalace (AI memory — optional)

```bash
pip3 install --user pipx
pipx install mempalace
```

---

## Initial Setup (First Time)

### 1. Create a GitHub Repository

1. Go to [GitHub](https://github.com/new) and create a repo named `dotfiles`
2. Choose **Public** (sensitive files are excluded via `.gitignore`)
3. **Do not** initialize with README, .gitignore, or license
4. Copy the repository URL

### 2. Initialize Bare Git Repository Locally

```bash
git init --bare $HOME/.dotfiles
```

### 3. Create the Dotfiles Alias

Add this to your `~/.zshrc` (or `~/.bashrc`):

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Then reload: `source ~/.zshrc`

### 4. Configure the Repository

```bash
dotfiles config --local status.showUntrackedFiles no
```

### 5. Create a .gitignore

Create `~/.gitignore` to exclude sensitive and generated files. See [What to Track vs Not Track](#what-to-track-vs-not-track) for the full list. Then track it:

```bash
dotfiles add ~/.gitignore
dotfiles commit -m "Add .gitignore"
```

### 6. Add Your Configuration Files

```bash
dotfiles add ~/.zshrc
dotfiles add ~/.config/nvim/
dotfiles add ~/README.md
dotfiles status
```

### 7. Make Your First Commit

```bash
dotfiles commit -m "Initial commit: zsh and nvim configuration"
```

### 8. Connect to GitHub and Push

```bash
dotfiles remote add origin https://github.com/yourusername/dotfiles.git
dotfiles branch -M main
dotfiles push -u origin main
```

---

## Setting Up on a New Machine

### Step 1 — Install prerequisites

See [Prerequisites](#prerequisites) above. At minimum: git, zsh, neovim, tmux, fzf, oh-my-zsh, Nerd Font.

### Step 2 — Clone the dotfiles repo

```bash
git clone --bare https://github.com/aaronrmcgrath/dotfiles.git $HOME/.dotfiles
```

### Step 3 — Define the alias (temporary)

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

### Step 4 — Checkout the files

```bash
dotfiles checkout
```

If checkout fails due to conflicts, back up the conflicting files first:

```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} sh -c 'mkdir -p ~/.dotfiles-backup/$(dirname "{}") && mv {} ~/.dotfiles-backup/{}'
dotfiles checkout
```

> **Oh My Zsh users:** If you installed oh-my-zsh before checking out dotfiles, the installer overwrote `~/.zshrc`. Re-checkout it:
> ```bash
> dotfiles checkout -- .zshrc
> ```

### Step 5 — Configure the repository

```bash
dotfiles config --local status.showUntrackedFiles no
```

### Step 6 — Set zsh as default shell

> **macOS:** `chsh -s $(which zsh)`

> **Linux (Pop!_OS/Ubuntu):** `chsh` often fails with a PAM authentication error. Use `usermod` instead:
> ```bash
> sudo usermod -s /usr/bin/zsh $USER
> ```
> Log out and back in for the change to take effect.

### Step 7 — Bootstrap the AI config layer

```bash
~/.ai/bin/init-machine         # generates ~/.ai/machine.md for this host
~/.ai/bin/compile-ai-config    # emits ~/AGENTS.md, SKILL.md files, symlinks
```

Then set up MemPalace local memory:

```bash
pipx install mempalace
mempalace init ~/.ai/palace              # accept proposed rooms
mempalace --palace ~/.ai/palace mine ~/.ai/
```

The MCP server and hooks are already configured in tracked `~/.claude/settings.json` — no extra steps needed.

### Step 8 — Reload your shell and verify

```bash
source ~/.zshrc
nvim --version              # should be 0.11+
dotfiles status             # should be clean
mempalace --palace ~/.ai/palace status   # should show drawers
```

---

## Syncing an Existing Machine

### Pull latest changes

```bash
dotfiles pull
```

### After pulling AI config changes

If `~/.ai/` content changed (new agents, skills, commands, or `user.md` updates):

```bash
~/.ai/bin/compile-ai-config    # regenerate AGENTS.md, SKILL.md, symlinks
```

If only `machine.md` needs a refresh (OS updated, tools added):

```bash
~/.ai/bin/init-machine
```

Compiled and generated files (`~/AGENTS.md`, `~/.ai/machine.md`, `~/.claude/skills/`, `~/.claude/agents/`, `~/.claude/commands/`) are not tracked — they're rebuilt from source on each machine.

### After a history rewrite (e.g., removing secrets)

If the remote history was force-pushed, a normal `dotfiles pull` will fail:

```bash
dotfiles fetch origin
dotfiles reset --hard origin/main
```

> **Warning:** This discards any local uncommitted changes to tracked files. Commit or back up first.

---

## Sharing Changes

### Making changes on one machine and syncing to another

```bash
# Machine A — after editing a dotfile:
dotfiles add ~/.zshrc
dotfiles commit -m "update: add flyctl alias"
dotfiles push

# Machine B:
dotfiles pull
source ~/.zshrc   # or restart shell
```

### What gets synced vs what doesn't

**Tracked (syncs via git):** source files in `~/.ai/`, `~/.claude/CLAUDE.md`, `~/.claude/settings.json`, nvim config, shell config, terminal config.

**Not tracked (rebuilt per machine):** `~/.ai/machine.md`, `~/AGENTS.md`, `~/.claude/skills/`, `~/.claude/agents/`, `~/.claude/commands/`, MemPalace vector data (`~/.ai/palace/*.sqlite3`, `~/.ai/palace/chroma/`).

Run `~/.ai/bin/compile-ai-config` after pulling if AI config changed.

---

## Daily Usage

The `dotfiles` command works exactly like `git`:

```bash
dotfiles status                                    # check modified tracked files
dotfiles diff                                      # review changes
dotfiles add ~/.zshrc                              # stage a file
dotfiles commit -m "Update shell config"           # commit
dotfiles push                                      # push to GitHub
dotfiles pull                                      # pull from GitHub
dotfiles log                                       # commit history
dotfiles ls-tree --full-tree -r --name-only HEAD   # list all tracked files
```

---

## Adding Files and Directories

### Individual files

```bash
dotfiles add ~/.tmux.conf
dotfiles commit -m "Add tmux config"
dotfiles push
```

### Entire directories

```bash
dotfiles add ~/.config/nvim/
dotfiles add ~/.config/fastfetch/
dotfiles commit -m "Add editor and terminal configurations"
dotfiles push
```

### Important: new files in tracked directories aren't auto-tracked

**Git only tracks files you explicitly add.** After the initial `dotfiles add`, new files you create won't be automatically tracked.

```bash
# New file created — NOT tracked yet:
nvim ~/.config/nvim/lua/plugins/new-plugin.lua

# Must add explicitly:
dotfiles add ~/.config/nvim/lua/plugins/new-plugin.lua
# or re-add the whole directory:
dotfiles add ~/.config/nvim/
```

---

## AI Config Layer

`~/.ai/` is a vendor-neutral source of truth for AI assistant configuration, tracked in this repo alongside the rest of the dotfiles.

### Structure

```
~/.ai/
  user.md             your role, preferences, and collaboration style
  machine.md          auto-generated per host (gitignored)
  init.md             design principles and layer map
  bin/
    init-machine      generates machine.md for the current host
    compile-ai-config emits AGENTS.md, SKILL.md files, and symlinks
  skills/domains/     domain skills (php, js, lua) — loaded progressively by Claude
  agents/             subagent definitions (orchestrator, programmer, tester, etc.)
  commands/           slash commands (/dev, /plan, /review, /test, /ship, /learn)
  mcp/
    servers.json      MCP server definitions (compiled into ~/.claude/settings.json)
  palace/             MemPalace local AI memory (partially gitignored)
    mempalace.yaml    wing/room config (tracked)
    *.sqlite3         vector DB (gitignored — machine-local)
    chroma/           ChromaDB data (gitignored — machine-local)
```

### How it works

- **Claude Code** reads `~/.claude/CLAUDE.md` which `@`-imports from `~/.ai/`. Agents and commands are symlinked into `~/.claude/agents/` and `~/.claude/commands/`.
- **Other AI tools** (Aider, Cursor, etc.) consume `~/AGENTS.md`, a compiled concatenation of the same sources.
- `compile-ai-config` produces all derived outputs. Re-run it after pulling if `~/.ai/` changed.

### MemPalace (local AI memory)

[MemPalace](https://github.com/mempalace/mempalace) gives the AI a persistent, local vector memory backed by ChromaDB. No API key required.

> **Warning:** `github.com/milla-jovovich/mempalace` is a fake/malicious fork — only use the official repo above.

The MCP server is configured in `~/.claude/settings.json` and starts automatically with Claude Code. Stop/PreCompact hooks auto-save session content to the palace.

Bootstrap on a new machine: see [Step 7](#step-7--bootstrap-the-ai-config-layer) above.

---

## Important Notes

### What to Track vs Not Track

**Good to track:**
- Shell configs (`.zshrc`, `.bashrc`)
- Editor configs (`~/.config/nvim/`)
- Terminal configs (`~/.config/alacritty/alacritty.toml`, `~/.tmux.conf`)
- Prompt config (`~/.config/starship.toml`)
- System info config (`~/.config/fastfetch/`)
- AI config source (`~/.ai/` — excluding `machine.md` and `palace/` data)
- Claude Code config (`~/.claude/CLAUDE.md`, `~/.claude/settings.json`)

**Don't track:**
- Git config (`.gitconfig`) — contains name and email
- History files (`.zsh_history`, `.bash_history`)
- SSH keys (`.ssh/id_*`)
- Oh My Zsh installation (`.oh-my-zsh/`) — reinstall from script
- nvm installation (`.nvm/`) — reinstall from script
- Cache directories (`.npm/`, `.cargo/`)
- API tokens/credentials (`.netrc`, `.aws/credentials`, `.claude.json`)
- AI-generated/compiled outputs (`AGENTS.md`, `~/.ai/machine.md`, `~/.claude/skills/`, `~/.claude/agents/`, `~/.claude/commands/`)
- MemPalace vector data (`~/.ai/palace/*.sqlite3`, `~/.ai/palace/chroma/`)

### Security Best Practices

- **Never commit sensitive files** — SSH keys, API tokens, credentials
- **Always run `dotfiles diff` before committing** to review exactly what changed
- Use `dotfiles status` to see which files are staged
- Avoid hardcoding paths with your username — use `$HOME` instead
- Consider making the repo private if unsure

### About Tracking New Files

- Git doesn't auto-track new files — you must explicitly `dotfiles add` them
- Re-add a directory (`dotfiles add ~/.config/nvim/`) to pick up new files within it

### Managing Oh My Zsh and Plugins

**Don't track Oh My Zsh itself** — it's large and easily reinstalled:

```bash
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

If you have custom themes/plugins, you can track `~/.oh-my-zsh/custom/` selectively.

---

## Troubleshooting

### "Too many files" in `dotfiles status`

```bash
dotfiles config --local status.showUntrackedFiles no
```

### Checkout fails on new machine due to conflicts

```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
  xargs -I{} sh -c 'mkdir -p ~/.dotfiles-backup/$(dirname "{}") && mv {} ~/.dotfiles-backup/{}'
dotfiles checkout
```

### `chsh` fails with authentication error (Linux)

```bash
sudo usermod -s /usr/bin/zsh $USER
```

### Neovim startup errors on Linux (LSP/Mason failures)

The `apt` package is too old (v0.9.5). Install via AppImage — see [Prerequisites → Neovim](#neovim).

If Mason LSP servers fail to install, check runtime deps:
- `basedpyright` requires `python3-venv`: `sudo apt install python3-venv`
- `gopls` requires Go to be installed and in PATH
- `csharp-language-server` requires `dotnet`

### Alacritty shows wrong or ugly font

The Nerd Font must be installed and registered before Alacritty references it. Verify:

```bash
fc-list | grep -i jetbrains
```

The registered family name is `JetBrainsMono Nerd Font` — use this exact string in `alacritty.toml`.

### List all tracked files

```bash
dotfiles ls-tree --full-tree -r --name-only HEAD
```

### Untrack a file (keep it locally)

```bash
dotfiles rm --cached ~/.sensitive-file
dotfiles commit -m "Stop tracking sensitive file"
dotfiles push
```

### Remove a file from Git history (if you committed secrets)

**Rotate any exposed credentials immediately**, then remove from history.

Install `git-filter-repo`:

> **macOS:** `brew install git-filter-repo`

> **Linux:** `pipx install git-filter-repo`

Since bare repos don't work directly with `git-filter-repo`, clone, rewrite, and force-push:

```bash
git clone https://github.com/aaronrmcgrath/dotfiles.git /tmp/dotfiles-cleanup
cd /tmp/dotfiles-cleanup
git filter-repo --invert-paths --path .gitconfig
git remote add origin https://github.com/aaronrmcgrath/dotfiles.git
git push origin main --force
rm -rf /tmp/dotfiles-cleanup
```

Then re-sync your bare repo:

```bash
dotfiles fetch origin
dotfiles reset --hard origin/main
```

---

## Resources

- [Atlassian Guide to Dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)
- [GitHub Dotfiles](https://dotfiles.github.io/)
- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [MemPalace](https://github.com/mempalace/mempalace)
