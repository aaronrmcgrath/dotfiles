


-- local vars
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- defaults
vim.opt.guicursor = ""
-- option for netrw index ("i") default is where shows trees when you enter files
vim.g.netrw_liststyle = 3

-- set cursorline
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000000" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#9663C4", bg = "#000000" })

-- hi cursorline cterm=none term=none
-- vim.hightlight.create("CursorLine", { cterm = "none", term = "none" })v

-- autocmd WinEnter * setlocal cursorline
autocmd("WinEnter", {
    pattern = "*",
    command = "setlocal cursorline",
})

-- autocmd WinLeave * setlocal nocursorline
autocmd("WinLeave", {
    pattern = "*",
    command = "setlocal nocursorline",
})

-- highlight CursorLine guibg=#000000 ctermbg=9
-- vim.highlight.add("CursorLine", {guibg = "#000000", ctermbg = 9 })

-- highlight Pmenu ctermbg=gray guibg=gray

vim.cmd('filetype plugin indent on')

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = ">-", eol = "$" }

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "95"

vim.g.mapleader = " "

vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" });
vim.fn.sign_define("DiagnosticSignWarn", { text = "⚠", texthl = "DiagnosticSignWarn" });
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", texthl = "DiagnosticSignInfo" });
vim.fn.sign_define("DiagnosticSignHint", { text = "➤", texthl = "DiagnosticSignHint" });

-- Configure diagnostics display
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})



