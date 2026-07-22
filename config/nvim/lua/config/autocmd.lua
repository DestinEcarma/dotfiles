-- Keymap helper
local map = vim.keymap.set

-- LSP Attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspBuffer", {}),
	callback = function(args)
		local buf = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then
			return
		end

        -- LSP keymaps
        -- stylua: ignore start
        map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition", buf = buf })
        map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", buf = buf, nowait = true })
        map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation", buf = buf })
        map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition", buf = buf })
        map("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration", buf = buf })
        map("n", "ge", vim.diagnostic.open_float, { desc = "Open Line Diagnostic", buf = buf })
        map("n", "K", vim.lsp.buf.hover, { desc = "Hover", buf = buf })
        map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buf = buf })
        map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", buf = buf })
        map("n", "<leader>cl", function() Snacks.picker.lsp_config() end, { desc = "Lsp Info", buf = buf })
        map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", buf = buf })
        map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buf = buf })
        map("n", "<leader>ih", function() Snacks.toggle.inlay_hints() end, { desc = "Display Inlay Hints", buf = buf })
		-- stylua: ignore end

		-- Codelens
		if client:supports_method("textDocument/codeLens") then
			local function codeLens()
				local enabled = vim.lsp.codelens.is_enabled({ bufnr = buf })
				vim.lsp.codelens.enable(not enabled, { bufnr = buf })
			end

			map("n", "<leader>cC", codeLens, { desc = "Display Codelens", buf = buf })
			map({ "n", "x" }, "<leader>cc", codeLens, { desc = "Run Codelens", buf = buf })
		end

		-- Navic (breadcrumbs)
		if client:supports_method("textDocument/documentSymbol") then
			require("nvim-navic").attach(client, buf)
			vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", {}),
	callback = function()
		if vim.fn.has("nvim-0.13") == 1 then
			vim.hl.hl_op()
		else
			(vim.hl or vim.highlight).on_yank()
		end
	end,
})

-- LazyFile event trigger
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("LazyFile", { clear = true }),
	callback = function()
		vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })
	end,
})
