-- Diagnostic navigation helper
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",

		---@module "which-key"
		---@type wk.Config
		opts = {
			spec = {
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Code" },
				{ "<leader>f", group = "Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>s", group = "Search / Session" },
				{ "<leader>u", group = "Uncategorized" },
			},
		},

        -- stylua: ignore
        keys = {
            -- Snacks Core
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
            {
                "<leader>n",
                function()
                    Snacks.picker.notifications({
                        layout = "vertical",
                        confirm = function (picker, item)
                            if not item then
                                return
                            end
                            picker:show_preview()
                            picker:focus("preview")
                        end
                    })
                end,
                desc = "Notification History"
            },
            { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },

            -- Find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },

            -- Git
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },

            -- Search
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Word / Selection", mode = { "n", "x" } },
            { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
            { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
            { "<leader>sc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

            -- Utilities
            { "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
            { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Zoom" },
            { "<leader>.", function() Snacks.scratch() end, desc = "Scratch Buffer" },
            { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch" },
            { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
            { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
            { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
            { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },
            { "<leader>v", function() vim.treesitter.select("parent") end, mode = { "n", "x" }, desc = "Increment Selection to Parent Node" },
            { "<leader>V", function() vim.treesitter.select("child") end, mode = "x", desc = "Decrement Selection to Child Node" },
            { "<leader>us", function () Snacks.picker.spelling() end, desc = "Spellings" },
            {
                "<leader>uq",
                function()
                    local items = {}

                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
                            local name = vim.api.nvim_buf_get_name(buf)
                            if name ~= "" then
                                table.insert(items, { filename = name, lnum = 1, col = 1, text = "unsaved buffer" })
                            end
                        end
                    end

                    vim.fn.setqflist({}, " ", { title = "Unsaved files", items = items })
                    vim.cmd.copen()
                end,
                desc = "Quickfix unsaved buffers"
            },

            -- Word Navigation
            { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
            { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
            { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference" },
            { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference" },

            -- Basic
            { "<C-s>", "<cmd>update<cr>", desc = "Save" },
            {
                "<C-q>",
                function()
                    if not pcall(vim.cmd, "close") then
                        if #vim.tbl_filter(function(b) return vim.bo[b].buflisted end, vim.api.nvim_list_bufs()) > 1 then
                            Snacks.bufdelete.delete()
                        else
                            vim.cmd("q")
                        end
                    end
                end,
                desc = "Quit Split / Delete Buffer / Quit",
            },
            { "<C-a>", "ggVG", desc = "Select All" },

            -- Resize Windows
            { "<C-Up>", "<cmd>resize +2<cr>", desc = "Increase Height" },
            { "<C-Down>", "<cmd>resize -2<cr>", desc = "Decrease Height" },
            { "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease Width" },
            { "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase Width" },

            -- Move Lines
            { "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", desc = "Move Down" },
            { "<A-j>", "<esc><cmd>m .+1<cr>==gi", mode = "i", desc = "Move Down" },
            { "<A-k>", "<esc><cmd>m .-2<cr>==gi", mode = "i", desc = "Move Up" },
            { "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", desc = "Move Up" },
            { "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", mode = "v", desc = "Move Down", silent = true },
            { "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", mode = "v", desc = "Move Up", silent = true },

            -- Buffers
            { "<S-h>", "<cmd>bprevious<cr>", desc = "Prev Buffer" },
            { "<S-l>", "<cmd>bnext<cr>", desc = "Next Buffer" },
            { "<leader>bd", function() Snacks.bufdelete.delete() end, desc = "Delete Buffers" },
            { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
            { "<leader>bt", function() Snacks.terminal.open(vim.fn.expand("%:p:h")) end, desc = "Open Terminal on Current Buffer" },

            -- Navigation Centering
            { "n", "nzzzv", desc = "Next Search Center" },
            { "N", "Nzzzv", desc = "Prev Search Center" },
            { "{", "{zz", desc = "Up Center" },
            { "}", "}zz", desc = "Down Center" },
            { "<C-u>", "<C-u>zz", desc = "Half Page Up" },
            { "<C-d>", "<C-d>zz", desc = "Half Page Down" },

            -- Indent
            { "<C-]>", ">>", desc = "Indent", },
            { "<C-[>", "<<", desc = "Unindent" },
            { "<C-]>", ">gv", mode = "v", desc = "Indent" },
            { "<C-[>", "<gv", mode = "v", desc = "Unindent" },

            -- Window Splits
            { "<leader>-", "<C-W>s", desc = "Split Below" },
            { "<leader>|", "<C-W>v", desc = "Split Right" },

            -- Diagnostics
            { "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
            { "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },
            { "]e", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
            { "[e", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
            { "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
            { "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
            { "ge", vim.diagnostic.open_float, desc = "Open Line Diagnostic" },

            -- Delete Without Yank
            { "<leader>dd", "\"_dd", mode = "n" },
            { "<leader>d", "\"_d", mode = { "n", "v" } },
            { "<leader>D", "\"_D", mode = { "n", "v" } },
            { "<leader>x", "\"_x", mode = { "n", "v" } },
            { "<leader>X", "\"_X", mode = { "n", "v" } },

            -- Better Movement
            { "j", "v:count == 0 ? 'gj' : 'j'", mode = { "n", "x" }, desc = "Down", expr = true, silent = true },
            { "<Down>", "v:count == 0 ? 'gj' : 'j'", mode = { "n", "x" }, desc = "Down", expr = true, silent = true },
            { "k", "v:count == 0 ? 'gk' : 'k'", mode = { "n", "x" }, desc = "Up", expr = true, silent = true },
            { "<Up>", "v:count == 0 ? 'gk' : 'k'", mode = { "n", "x" }, desc = "Up", expr = true, silent = true },

            -- Quickfix
            { "<leader>q", function() require("quicker").toggle() end, desc = "Toggle Quickfix" },
            { "<M-l>", "<cmd>cnext<cr>", desc = "Next Quickfix" },
            { "<M-h>", "<cmd>cprev<cr>", desc = "Prev Quickfix" },

            -- Session
            { "<leader>ss", function() require("local.sessions").save_session() end, desc = "Save Session", },
            { "<leader>sr", function() require("local.sessions").restore_session() end, desc = "Restore Session" },
            { "<leader>sl", function() require("local.sessions").session_list() end, desc = "List Sessions" },

            -- Comments
            { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo", },
            { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme", },

            -- Terminal
            { "<M-`>", "<cmd>FloatTermToggle<cr>", mode = { "n", "t" }, desc = "Toggle Floating Terminal" },
            { "<M-S-`>", "<cmd>FloatTermNew<cr>", mode = { "n", "t" }, desc = "New Floating Terminal" },
            { "]t", "<cmd>FloatTermNext<cr>", desc = "Next Floating Terminal" },
            { "[t", "<cmd>FloatTermPrev<cr>", desc = "Prev Floating Terminal" },
            { "<esc><esc>", "<C-\\><C-n>", mode = "t" },
        },
	},
}
