return {
    'folke/tokyonight.nvim',
    lazy = false,
    config = function ()
        vim.cmd('colorscheme tokyonight')
    end,
    opts = { style = 'storm' },
}
