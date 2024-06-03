return {
  -- lspconfig
  {
    'neovim/nvim-lspconfig',
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'rust_analyzer',
          'tsserver',
          'eslint',
        },
        handlers = {
          function(server_name)
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
            })
          end,
          -- Next, you can provide targeted overrides for specific servers.
          ['lua_ls'] = require('plugins.lsp.lua_ls'),
          ['rust_analyzer'] = require('plugins.lsp.rust_analyzer'),
          ['jdtls'] = require('plugins.lsp.jdtls'),
        }
      })
    end,
  },
  { 'mfussenegger/nvim-jdtls' },
}
