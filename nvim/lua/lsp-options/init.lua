local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
}
