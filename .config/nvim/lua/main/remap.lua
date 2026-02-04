


-- leader key: space bar
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)



-- shortcut for quitting/exiting vim ':q!'
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>")
-- moves highlighted line up and indents properly
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- moves highlighted line down and indents properly
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- command mode alternative - quicker! ;)
vim.keymap.set("n", "<leader>;", ":")
-- quickly lets you escape insert mode by doing different combos of 'j' and 'k'
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
-- while in insert mode creates a new line above current line like 'O' in normal mode
vim.keymap.set("i", "<C-k>", "<Esc>O<Esc>jA")
-- alternative mapping for 'G' to get more quickly to the bottom of the file
vim.keymap.set("n", "<leader>g", "G")
-- alternative navigation for 'u' (up) and 'd' (down) to keep curso in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- will paste original yanked or copied item instead of replaced one if you paste over
-- another text - default behavior would add the deleted text to the pasted text
vim.keymap.set("x", "<leader>p", "\"_dP")
-- updates "n" while searching to keep cursor in the middle of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- alternative for moving between buffer windows, acts similar to h,j,k, and l
-- but for window/buffer navigation. 'h' = left and 'k' = down for example
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")
-- paste in normal mode? (next line and previous line)
vim.keymap.set("n", "<leader>p", "0p")
vim.keymap.set("n", "<leader>P", "0P")
-- alternative to cycle through buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
-- shortcut for command ':Rexplore' to get back to netrw explorer
vim.keymap.set("n", "<leader>b", "<cmd>Rexplore<CR>")
-- shortcut for command ':set nornu' to remove relative line numbers -- helpful for when
-- screen sharing or pair programming -- relative line numbers can throw people off
vim.keymap.set("n", "<leader>ln", "<cmd>set nornu<CR>")
-- shortcut for command ':set rnu' to change back to relative line numbers if removed
vim.keymap.set("n", "<leader>rn", "<cmd>set rnu<CR>")
--vnoremap <Leader>y "*y
--vnoremap <Leader>yy "*yy
-- alternative pastes
-- leader-y selects highlighted text to global clipboard while in visual mode
vim.keymap.set("v", "<leader>y", "\"*y")
-- leader-y-y selects current line to clipboard -- may be broken right now
vim.keymap.set("n", "<leader>yy", "\"*yy")
-- leader-y-y selects current line to clipboard -- may be broken right now
vim.keymap.set("n", "<leader>yy", "\"*yy")
-- open %s (search | /) in command mode (:) and uses current word your cursor
-- is on to search and replace
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
-- when saving a new file or any file you can run the following to update permissions
-- and run the file as an executable (!chmode +x)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")
-- opens searchable quick list of projects to open
-- maybe doesn't work, need tmux??
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")



-- plugin remaps
-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- zenmode
vim.keymap.set({"n", "v", "i"}, "<leader>z", "<cmd>ZenMode<CR>")


-- LSP KEYMAPS
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
-- additional useful mappings for C# dev
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic error messages" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- sonar lint
vim.keymap.set("n", "<leader>td", function()
    local diagnostics_active = vim.diagnostic.is_disabled()
    if diagnostics_active then
        vim.diagnostic.enable()
    else
        vim.diagnostic.disable()
    end
end, {desc = "Toggle Diagnostics" })

-- toggle specific diagnostic severity levels
vim.keymap.set("n", "<leader>dl", function()
    local current_diagnostics = vim.diagnostic.config().severity_sort
    vim.diagnostic.config({
        virtual_text = {
            severity = {
                min = vim.diagnostic.severity.Error,
                max = vim.diagnostic.severity.Error,
            }
        }
    })
end, { desc = "Show Errors Only" })

vim.keymap.set("n", "<leader>da", function()
    vim.diagnostic.config({
        virtual_text = true, -- reset to show all severities
    })
end, { desc = "Show All Diagnostics"})

vim.keymap.set("n", "<leader>ls", function()
    local active_clients = vim.lsp.get_active_clients()
    print(vim.inspect(active_clients))
end, { desc = "Show LSP Status" })

-- Prose writing keybindings
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })
vim.keymap.set("n", "<leader>ps", function()
    vim.cmd("PencilSoft")
end, { desc = "Enable Pencil Soft Wrap" })
vim.keymap.set("n", "<leader>ph", function()
    vim.cmd("PencilHard")
end, { desc = "Enable Pencil Hard Wrap" })
vim.keymap.set("n", "<leader>po", function()
    vim.cmd("PencilOff")
end, { desc = "Disable Pencil" })

-- Quick spell correction
vim.keymap.set("n", "<C-s>", "[s1z=<c-o>", { desc = "Fix spelling (top suggestion)" })
vim.keymap.set("i", "<C-s>", "<c-g>u<Esc>[s1z=`]A<c-g>u", { desc = "Fix spelling in insert mode" })



