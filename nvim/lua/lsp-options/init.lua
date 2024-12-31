local merge_tables = require("utils.merge-tables")

local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),

	on_attach = function(client, bufner)
		local opts = { silent = true, buffer = bufner }

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "K", vim.lsp.buf.hover, merge_tables(opts, { desc = "Display Documentation" }))
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, merge_tables(opts, { desc = "Go to Definition" }))
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, merge_tables(opts, { desc = "Go to Declaration" }))
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, merge_tables(opts, { desc = "Go to Implementation" }))

		vim.keymap.set(
			"n",
			"<leader>e",
			vim.diagnostic.open_float,
			merge_tables(opts, { desc = "Display Line Diagnostics" })
		)
		vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, merge_tables(opts, { desc = "Rename" }))
		vim.keymap.set("n", "<leader>td", vim.lsp.buf.type_definition, merge_tables(opts, { desc = "Type Definition" }))
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, merge_tables(opts, { desc = "Code Action" }))

		if client.server_capabilities.inlayHintProvider then
			vim.keymap.set("n", "<leader>ih", function()
				local value = vim.lsp.inlay_hint.is_enabled()

				vim.lsp.inlay_hint.enable(not value)

				print("Inlay Hints " .. (value and "disabled" or "enabled"))
			end, merge_tables(opts, { desc = "Display Inlay Hints" }))
		end

		-- Telescope
		vim.keymap.set(
			"n",
			"<leader>fr",
			builtin.lsp_references,
			merge_tables(opts, { desc = "Telescope LSP References" })
		)
		vim.keymap.set(
			"n",
			"<leader>fd",
			builtin.diagnostics,
			merge_tables(opts, { desc = "Telescope LSP Diagnostics" })
		)
		vim.keymap.set("n", "<leader>fq", builtin.quickfix, merge_tables(opts, { desc = "Telescope LSP Quickfix" }))
	end,
}
