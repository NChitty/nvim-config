local builtin = require('telescope.builtin')
vim.keymap.set('n', 'gc', builtin.find_files, {})
vim.keymap.set('n', 'gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>ss', function ()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)