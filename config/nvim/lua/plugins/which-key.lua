local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

vim.g.mapleader = " "

-- Better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspBuffer", {}),
	callback = function(args)
		local wk = require("which-key")

		local buf = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if not client then
			return
		end

		wk.add({
			-- stylua: ignore start
			{ "gd", Snacks.picker.lsp_definitions, desc = "Goto Definition", },
			{ "gr", Snacks.picker.lsp_references, desc = "References", nowait = true },
			{ "gI", Snacks.picker.lsp_implementations, desc = "Goto Implementation", },
			{ "gy", Snacks.picker.lsp_type_definitions, desc = "Goto Type Definition", },
			{ "gD", Snacks.picker.lsp_declarations, desc = "Goto Declaration", },
			{ "ge", vim.diagnostic.open_float, desc = "Open Line Diagnostic" },
			{ "K",  vim.lsp.buf.hover, desc = "Hover", },
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help", },
			{ "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", },
			{ "<leader>c", group = "Code" },
			{ "<leader>cl", Snacks.picker.lsp_config, desc = "Lsp Info", },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename", },
			{ "<leader>ca", vim.lsp.buf.code_action, mode = { "n", "x" }, desc = "Code Action", },
			{ "<leader>ih", Snacks.toggle.inlay_hints, desc = "Display Inlay Hints", mode = "n", },
			-- stylua: ignore end
		}, { buffer = buf })

		if client:supports_method("textDocument/codeLens") then
			local function codeLens()
				local enabled = vim.lsp.codelens.is_enabled({ bufnr = buf })
				vim.lsp.codelens.enable(not enabled, { bufnr = buf })
			end

			wk.add({
				{ "<leader>cC", codeLens, desc = "Display Codelens" },
				{ "<leader>cc", vim.lsp.codelens.run, mode = { "n", "x" }, desc = "Run Codelens" },
			}, { buffer = buf })
		end

		if client:supports_method("textDocument/documentSymbol") then
			require("nvim-navic").attach(client, buf)
			vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
		end
	end,
})

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = { "echasnovski/mini.nvim" },
	keys = {
		-- stylua: ignore start
		-- Top Pickers & Explorer
		{ "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
		{ "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
		{ "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

		-- Find
		{ "<leader>f", group = "Find" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
		{ "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
		{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },

		-- Git
		{ "<leader>g", group = "Git" },
		{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
		{ "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
		{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
		{ "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
		{ "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		{ "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

		-- Grep
		{ "<leader>s", group = "Search" },
		{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
		{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
		{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

		-- Search
		{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
		{ '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
		{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
		{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
		{ "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
		{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
		{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
		{ "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
		{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
		{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
		{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
		{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
		{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
		{ "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
		{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
		{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
		{ "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
		{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
	
		-- Other
		{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
		{ "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
		{ "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
		{ "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
		{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
		{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
		{ "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
		{ "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
		{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
		{ "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
		{ "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", },
		{ "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", },
		{ "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference", },
		{ "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference", },


		-- Utils
		{ "<C-s>", "<cmd>w<CR>", desc = "Save" },
		{ "<C-q>", "<cmd>q<CR>", desc = "Quit" },
		{ "<C-a>", "ggVG", desc = "Select All" },

		-- Resize window using <ctrl> arrow keys
		{ "<C-Up>", "<cmd>resize +2<cr>", desc = "Increase Window Height" },
		{ "<C-Down>", "<cmd>resize -2<cr>", desc = "Decrease Window Height" },
		{ "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease Window Width" },
		{ "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase Window Width" },

		-- Move Lines
		{ "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", desc = "Move Down", },
		{ "<A-j>", "<esc><cmd>m .+1<cr>==gi", mode = "i", desc = "Move Down",  },
		{ "<A-k>", "<esc><cmd>m .-2<cr>==gi", mode = "i", desc = "Move Up", },
		{ "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", desc = "Move Up",  },
		{ "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", mode = "v", desc = "Move Down", silent = true },
		{ "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", mode = "v", desc = "Move Up", silent = true },

		-- Buffers
		{ "<S-h>", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
		{ "<S-l>", "<cmd>bnext<cr>", desc = "Next Buffer" },

		-- Move Up/Down and Center
		{ "n", "{", "{zz", desc = "Move Up and Center" },
		{ "n", "}", "}zz", desc = "Move Down and Center" },

		-- Tab Indent
		{ "n", "<C-]>", ">>", desc = "Indent Line" },
		{ "n", "<C-[>", "<<", desc = "Unindent Line" },
		{ "v", "<C-]>", ">gv", desc = "Indent Line" },
		{ "v", "<C-[>", "<gv", desc = "Unindent Line" },

		-- Tab window
		{ "<leader><tab><tab>", "<cmd>tabnew<CR>", desc = "New Tab" },
		{ "<leader><tab>]", "<cmd>tabnext<CR>", desc = "Next Tab" },
		{ "<leader><tab>[", "<cmd>tabprevious<CR>", desc = "Prev Tab" },

		-- Split window
		{ "<leader>-", "<C-W>s", desc = "Split Window Below", },
		{ "<leader>|", "<C-W>v", desc = "Split Window Right", },
		{ "«", "<C-W>s", desc = "Split Window Right" },
		
		-- Diagnostic
		{ "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
		{ "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },
		{ "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
		{ "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
		{ "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
		{ "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
		-- stylua: ignore end
	},
}
