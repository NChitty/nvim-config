return function()
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
      ['rust_analyzer'] = {
        cargo = {
          buildScripts = {
            enable = true
          }
        },
        diagnostics = {
          experimental = true
        },
        procMacro = {
          enable = true
        },
      }
    }
  })
end
