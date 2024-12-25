local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),

	on_attach = function(_, bufner)
		local opts = { silent = true, buffer = bufner }

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		-- Telescope
		vim.keymap.set("n", "<leader>fr", builtin.lsp_references, opts)
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, opts)
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, opts)

		vim.keymap.set("n", "<leader>e", vim.lsp.diagnostic.get_line_diagnostics, opts)
		vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
}
