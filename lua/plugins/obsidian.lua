return {
    'epwalsh/obsidian.nvim',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        workspaces = {
            {
                name = 'personal',
                path = '~/personal/vaults/personal',
            }
        },
        daily_notes = {
            folder = 'dailies',
            date_format = '%Y-%m-%d',
        },
        new_notes_location = "current_dir",
        preferred_link_style = "markdown",
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        },
    },
}
