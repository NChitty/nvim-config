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
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
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
          ['lua_ls'] = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' }
                  }
                }
              }
            })
          end,
          ['rust_analyzer'] = function()
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
          end,
          ['jdtls'] = function()
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local home = os.getenv('HOME')
            local jdtls_setup = require('jdtls.setup')

            local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
            local root_dir = jdtls_setup.find_root(root_markers)

            local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
            local workspace_dir = home .. '/.cache/jdtls/workspace' .. project_name

            local mason_packages = home .. '/.local/share/nvim/mason/packages'

            local path_to_jdtls = mason_packages .. '/jdtls'

            local path_to_config = path_to_jdtls .. '/config_linux'
            local lombok_path = path_to_jdtls .. '/lombok.jar'

            local path_to_jar = path_to_jdtls .. '/plugins/org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar'
            lspconfig.jdtls.setup({
              capabilities = capabilities,
              flags = {
                allow_incremental_sync = true
              },
              cmd = {
                'java',
                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-Xmx1g',
                '-javaagent:' .. lombok_path,
                '--add-modules=ALL-SYSTEM',
                '--add-opens',
                'java.base/java.util=ALL-UNNAMED',
                '--add-opens',
                'java.base/java.lang=ALL-UNNAMED',
                '-jar',
                path_to_jar,
                '-configuration',
                path_to_config,
                '-data',
                workspace_dir,
              },
              settings = {
                java = {
                  references = {
                    includeDecompiledSources = true,
                  },
                  format = {
                    enabled = true,
                    settings = {
                      url = vim.fn.stdpath('config') .. '/lang_servers/intellij-java-google-style.xml',
                      profile = 'GoogleStyle',
                    },
                  },
                  eclipse = {
                    downloadSources = true,
                  },
                  maven = {
                    downloadSources = true,
                  },
                  signatureHelp = { enabled = true },
                }
              }

            })
          end,
        }
      })

      -- Set up nvim-cmp.
      local cmp = require 'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-c>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
  {
    'mfussenegger/nvim-jdtls',
  },
}
