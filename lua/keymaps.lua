vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set("n", "<leader>jf", '<cmd>Neotree toggle<CR>')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>=", vim.lsp.buf.format)

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

---------------
-- Add new line
---------------
vim.keymap.set("n", "o", "o<ESC>")
vim.keymap.set("n","<leader>o", "A<Enter>")
vim.keymap.set("n","O", "O<ESC>")
vim.keymap.set("n","<leader>O", "kA<Enter>")

-----------------------------------------------------
-- Screen movements keep cursor near center of screen
-----------------------------------------------------
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
vim.keymap.set("n", "<c-f>", "<c-f>zz")
vim.keymap.set("n", "<c-b>", "<c-b>zz")

-------------------------------------------
-- Copy/Paste/Delete Behavior Modifications
-------------------------------------------

------
-- c
------

-- Normal change does not save values
vim.keymap.set("n", "c", [["_c]])

-- Special change saves values
vim.keymap.set("n", "<leader>c", "c")

-- 'Change to end of line' does not save values
vim.keymap.set("n", "C", [["_C]])

-- Special 'change to end of line' saves values
vim.keymap.set("n", "<leader>C", "C")

-- Normal visual change does not save values
vim.keymap.set("v", "c", [["_c]])

-- Special visual change saves values (like 'cut')
vim.keymap.set("v", "<leader>c", "c")

------
-- d
------

-- Normal delete does not save values
vim.keymap.set("n", "d", [["_d]])

-- Special delete saves values
vim.keymap.set("n", "<leader>d", "d")

-- Delete to end of line does not save values
vim.keymap.set("n", "D", [["_D]])

-- Special 'delete to end of line' saves values
vim.keymap.set("n", "<leader>D", "D")

-- Normal visual delete does not save values
vim.keymap.set("v", "d", [["_d]])

-- Special visual delete saves values (like 'cut')
vim.keymap.set("v", "<leader>d", "d")


------
-- p
------

-- Normal put does not save highlighted values
vim.keymap.set("x", "p", [["_dP]])

-- Special put saves highlight to buffer
vim.keymap.set("x", "<leader>p", "p")

------
-- x
------

-- Normal character delete does not save values
vim.keymap.set("n", "x", [["_x"]])

-------------
-- LSP Remaps
-------------
vim.keymap.set('n', '<leader>ne', vim.diagnostic.goto_next, { desc = 'Go to [N]ext [E]rror message' })
vim.keymap.set('n', '<leader>pe', vim.diagnostic.goto_prev, { desc = 'Go to [P]revious [E]rror message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('NChitty', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'i'}, '<C-s>', vim.lsp.buf.signature_help, opts)
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
