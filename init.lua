vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/lua/snippets/"

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'
