local lsp = require('lsp-zero').preset({})

lsp.preset("recommended")

lsp.ensure_installed({
	'rust_analyzer',
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
