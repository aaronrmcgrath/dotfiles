  # Dotfiles

  My personal dotfiles managed using a bare Git repository. This approach keeps configuration files in their proper locations without symlinks.

  ## Table of Contents

  - [Quick Start](#quick-start)
  - [Initial Setup (First Time)](#initial-setup-first-time)
  - [Daily Usage](#daily-usage)
  - [Adding Files and Directories](#adding-files-and-directories)
  - [Setting Up on a New Machine](#setting-up-on-a-new-machine)
  - [Syncing an Existing Machine](#syncing-an-existing-machine)
  - [Important Notes](#important-notes)
  - [Troubleshooting](#troubleshooting)

  ## Quick Start

  This dotfiles setup uses a **bare Git repository** with your home directory as the work tree. No symlinks required!

  **Key concept:** The `dotfiles` command is an alias that works exactly like `git`, but manages files in your home directory using a hidden `.dotfiles` repository.

  ## Initial Setup (First Time)

  ### 1. Create a GitHub Repository

  1. Go to [GitHub](https://github.com/new)
  2. Create a new repository named `dotfiles`
  3. Choose **Public** (we'll exclude sensitive files via `.gitignore`)
  4. **Do not** initialize with README, .gitignore, or license
  5. Copy the repository URL (e.g., `https://github.com/yourusername/dotfiles.git`)

  ### 2. Initialize Bare Git Repository Locally

  ```bash
  # Create a bare repository in your home directory
  git init --bare $HOME/.dotfiles
  ```

  This creates `~/.dotfiles/` containing only Git metadata (no working directory).

  ### 3. Create the Dotfiles Alias

  Add this to your `~/.zshrc` (or `~/.bashrc` if using Bash):

  ```bash
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  ```

  Then reload your shell:

  ```bash
  source ~/.zshrc
  ```

  **What this alias does:**
  - `--git-dir=$HOME/.dotfiles/` - Use `.dotfiles` as the Git repository
  - `--work-tree=$HOME` - Use your home directory as the working tree

  ### 4. Configure the Repository

  Hide untracked files (prevents `dotfiles status` from showing every file in your home directory):

  ```bash
  dotfiles config --local status.showUntrackedFiles no
  ```

  ### 5. Create a .gitignore

  Create `~/.gitignore` to exclude sensitive files:

  ```bash
  # Sensitive files
  .gitconfig
  .ssh/*_rsa
  .ssh/*_rsa.pub
  .ssh/id_*
  .ssh/known_hosts
  .netrc
  .aws/credentials
  .claude.json*

  # History and cache files
  .zsh_history
  .bash_history
  .zcompdump*
  .viminfo
  .lesshst
  .psql_history
  .python_history
  .node_repl_history

  # Package managers and large directories
  .oh-my-zsh/
  .nvm/
  .npm/
  .node-gyp/
  .rbenv/
  .composer/
  .cargo/
  node_modules/

  # OS files
  .DS_Store
  .Trash/
  ```

  Then track the .gitignore:

  ```bash
  dotfiles add ~/.gitignore
  dotfiles commit -m "Add .gitignore"
  ```

  ### 6. Add Your Configuration Files

  Start with essential files:

  ```bash
  # Add shell configuration
  dotfiles add ~/.zshrc

  # Add entire Neovim configuration directory
  dotfiles add ~/.config/nvim/

  # Add this README
  dotfiles add ~/README.md

  # Check what will be committed
  dotfiles status
  ```

  ### 7. Make Your First Commit

  ```bash
  dotfiles commit -m "Initial commit: zsh and nvim configuration"
  ```

  ### 8. Connect to GitHub and Push

  ```bash
  # Add your GitHub repository as remote
  dotfiles remote add origin https://github.com/yourusername/dotfiles.git

  # Push to GitHub
  dotfiles branch -M main
  dotfiles push -u origin main
  ```

  ## Daily Usage

  The `dotfiles` command works exactly like `git`:

  ```bash
  # Check status
  dotfiles status

  # Review changes before committing
  dotfiles diff

  # Add a file
  dotfiles add ~/.zshrc

  # Commit changes
  dotfiles commit -m "Update shell configuration"

  # Push to GitHub
  dotfiles push

  # Pull changes from another machine
  dotfiles pull

  # View commit history
  dotfiles log

  # See what's tracked
  dotfiles ls-tree --full-tree -r --name-only HEAD
  ```

  ## Adding Files and Directories

  ### Adding Individual Files

  ```bash
  dotfiles add ~/.p10k.zsh
  dotfiles add ~/.tmux.conf
  dotfiles commit -m "Add powerlevel10k and tmux config"
  dotfiles push
  ```

  ### Adding Entire Directories

  ```bash
  # Add all files in a directory recursively
  dotfiles add ~/.config/nvim/

  # Add multiple directories
  dotfiles add ~/.config/gh/
  dotfiles add ~/.config/iterm2/

  dotfiles commit -m "Add editor and terminal configurations"
  dotfiles push
  ```

  ### Important: Tracking New Files

  **Git only tracks files you explicitly add.** After the initial `dotfiles add`, new files you create won't be automatically tracked.

  ```bash
  # Create a new file in nvim config
  nvim ~/.config/nvim/lua/plugins/new-plugin.lua

  # This new file is NOT tracked yet
  dotfiles status  # Won't show the new file

  # You must add it explicitly
  dotfiles add ~/.config/nvim/lua/plugins/new-plugin.lua
  # OR re-add the entire directory
  dotfiles add ~/.config/nvim/

  dotfiles commit -m "Add new neovim plugin"
  dotfiles push
  ```

  **Pro tip:** If you frequently add files to a directory like `~/.config/nvim/`, you can re-run `dotfiles add ~/.config/nvim/` periodically to pick up new files.

  ## Setting Up on a New Machine

  ### Prerequisites

  Install these first:
  - Git
  - Your shell (zsh/bash)
  - Any tools your dotfiles configure (neovim, etc.)

  ### Setup Steps

  #### 1. Clone the Dotfiles Repository as a Bare Repo

  ```bash
  # Clone your dotfiles as a bare repository
  git clone --bare https://github.com/yourusername/dotfiles.git $HOME/.dotfiles
  ```

  #### 2. Define the Dotfiles Alias (Temporary)

  ```bash
  # Create a temporary alias for this session
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  ```

  #### 3. Checkout the Files

  ```bash
  # Backup any existing conflicting files
  mkdir -p .dotfiles-backup

  # Checkout the dotfiles
  dotfiles checkout

  # If checkout fails due to conflicts, backup those files:
  # Note: this flattens directory structure into .dotfiles-backup/
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} sh -c 'mkdir -p .dotfiles-backup/$(dirname "{}") && mv {} .dotfiles-backup/{}'

  # Try checkout again
  dotfiles checkout
  ```

  #### 4. Configure the Repository

  ```bash
  # Hide untracked files
  dotfiles config --local status.showUntrackedFiles no
  ```

  #### 5. Reload Your Shell

  ```bash
  # The dotfiles alias is now in your .zshrc (which was just checked out)
  source ~/.zshrc

  # The alias is now permanent!
  ```

  #### 6. Verify Setup

  ```bash
  # Check status
  dotfiles status

  # List all tracked files
  dotfiles ls-tree --full-tree -r --name-only HEAD
  ```

  You're done! Your dotfiles are now managed on the new machine.

  ## Syncing an Existing Machine

  ### Pulling Latest Changes

  If you updated your dotfiles on one machine and want to sync another:

  ```bash
  dotfiles pull
  ```

  ### After a History Rewrite (e.g., removing secrets with git filter-repo)

  If the remote history was rewritten (force-pushed), a normal `dotfiles pull` will fail. Re-sync with:

  ```bash
  dotfiles fetch origin
  dotfiles reset --hard origin/main
  ```

  **Warning:** This discards any local uncommitted changes to tracked files. Commit or back up local changes first.

  ## Important Notes

  ### About Tracking New Files

  - **Git doesn't auto-track new files** - You must explicitly `dotfiles add` them
  - After adding files to a tracked directory, run `dotfiles add <directory>` again to pick them up
  - Use `dotfiles status` to see modified files (but it won't show new untracked files by design)

  ### Security Best Practices

  - **Never commit sensitive files** (SSH keys, API tokens, credentials, `.gitconfig`)
  - Review `.gitignore` to ensure exclusions are comprehensive
  - **Always run `dotfiles diff` before committing** to review exactly what changed
  - Use `dotfiles status` to see which files are staged
  - Avoid hardcoding paths with your username (e.g., `/Users/yourname/`) — use `$HOME` instead
  - Consider making repo private if you're unsure about security

  ### What to Track vs Not Track

  **Good to track:**
  - Shell configs (`.zshrc`, `.bashrc`)
  - Editor configs (`~/.config/nvim/`, `.vimrc`)
  - Terminal configs (`~/.config/iterm2/`, `.tmux.conf`)
  - Tool configs (`~/.config/gh/`, `.p10k.zsh`)

  **Don't track:**
  - Git config (`.gitconfig`) - contains your name and email
  - History files (`.zsh_history`, `.bash_history`)
  - SSH keys (`.ssh/id_*`, `.ssh/*_rsa`)
  - Cache directories (`.oh-my-zsh/`, `.npm/`, `.cargo/`)
  - API tokens/credentials (`.netrc`, `.aws/credentials`)
  - Package manager directories (`node_modules/`, `vendor/`)

  ### Managing Oh-My-Zsh and Plugins

  **Don't track Oh-My-Zsh itself** - it's large and can be easily reinstalled:

  ```bash
  # On a new machine, install Oh-My-Zsh first
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Then checkout your dotfiles (which include .zshrc with your plugin configs)
  ```

  **If you have custom themes/plugins**, you might track:
  - `~/.oh-my-zsh/custom/` (your custom plugins and themes only)

  ## Troubleshooting

  ### "Too many files" when running `dotfiles status`

  If you forgot to run the config command:

  ```bash
  dotfiles config --local status.showUntrackedFiles no
  ```

  ### Files aren't being tracked after adding them

  Make sure you committed and pushed:

  ```bash
  dotfiles status  # Check what's staged
  dotfiles commit -m "Add new files"
  dotfiles push
  ```

  ### Checkout fails on new machine due to conflicts

  Backup conflicting files first:

  ```bash
  mkdir -p ~/.dotfiles-backup
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
    xargs -I{} sh -c 'mkdir -p ~/.dotfiles-backup/$(dirname "{}") && mv {} ~/.dotfiles-backup/{}'
  dotfiles checkout
  ```

  ### How to see all tracked files

  ```bash
  dotfiles ls-tree --full-tree -r --name-only HEAD
  ```

  ### How to untrack a file (but keep it locally)

  ```bash
  dotfiles rm --cached ~/.sensitive-file
  dotfiles commit -m "Stop tracking sensitive file"
  dotfiles push
  ```

  ### How to remove a file from Git history (if you committed secrets)

  **Rotate any exposed credentials immediately**, then remove the file from history.

  **This rewrites history - only do this if necessary:**

  Install `git-filter-repo` if you don't have it:

  ```bash
  brew install git-filter-repo
  ```

  Since bare repos don't work directly with `git-filter-repo`, clone, rewrite, and force-push:

  ```bash
  # Clone your repo normally into a temp directory
  git clone https://github.com/yourusername/dotfiles.git /tmp/dotfiles-cleanup
  cd /tmp/dotfiles-cleanup

  # Remove the sensitive file from all commits
  git filter-repo --invert-paths --path .gitconfig

  # Force-push the rewritten history
  git remote add origin https://github.com/yourusername/dotfiles.git
  git push origin main --force

  # Clean up
  rm -rf /tmp/dotfiles-cleanup
  ```

  Then re-sync your bare repo (see [Syncing an Existing Machine](#syncing-an-existing-machine)):

  ```bash
  dotfiles fetch origin
  dotfiles reset --hard origin/main
  ```

  ## Resources

  - [Atlassian Guide to Dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)
  - [GitHub Dotfiles](https://dotfiles.github.io/)
  - [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)

  ---

  **Happy configuring! 🚀**
