vim.g.mapleader = " "

vim.keymap.set("n", "<leader>jf", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<c-s>", vim.cmd.w)
vim.keymap.set("n", "<leader>=", vim.lsp.buf.format)

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

-- Special character delete saves values
vim.keymap.set("n", "<leader>x", "x")
