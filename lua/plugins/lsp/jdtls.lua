return function()
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

  local path_to_jar = path_to_jdtls .. '/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'
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
end
