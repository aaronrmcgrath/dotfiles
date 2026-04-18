# Lua / Neovim Configuration

## Environment

- **Neovim** (latest stable or nightly) as the primary editor.
- Config lives in `~/.config/nvim/`; tracked in the dotfiles bare repo.
- **lazy.nvim** as the plugin manager.

## Config Structure

```
~/.config/nvim/
  init.lua               entry point — minimal, delegates to modules
  lua/
    config/
      options.lua        vim.opt settings
      keymaps.lua        global keymaps
      autocmds.lua       autocommands
    plugins/             lazy.nvim plugin specs (one file per plugin or group)
```

## Plugin Conventions

- Each plugin spec is a table returned from a file in `lua/plugins/`.
- Use `lazy = true` by default; load on event, ft, or keys.
- Prefer `config = function() ... end` over `setup({})` for complex configs.
- Keep plugin configs self-contained in the spec file.

## LSP

- **nvim-lspconfig** for server setup; **mason.nvim** for server installation.
- **none-ls** (null-ls fork) or native LSP formatting for formatters/linters.
- Completion via **nvim-cmp** + sources (lsp, buffer, path, snippets).
- Treesitter for syntax highlighting and textobjects.

## Lua Style

- Prefer local variables; avoid globals.
- Use `vim.api.*`, `vim.fn.*`, and `vim.keymap.set` (not the legacy `vim.api.nvim_set_keymap`).
- Keymaps: always pass `{ noremap = true, silent = true }` (or use `vim.keymap.set` defaults).
- No magic strings for key mappings — define leader key once in `options.lua`.

## Common Patterns

```lua
-- Keymap
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })

-- Autocommand
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.lua',
  callback = function() vim.lsp.buf.format({ async = false }) end,
})
```
