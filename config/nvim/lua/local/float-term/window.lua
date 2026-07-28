local terminal = require("local.float-term.terminal")
local config = require("local.float-term.config")
local ui = require("local.float-term.ui")

local M = {}
M.__index = M

function M.new(opts)
	opts = vim.tbl_deep_extend("force", config.opts or {}, opts or {})

	local self = setmetatable({ opts = opts }, M)

	self.terminals = { terminal.new(opts.terminal) }
	self.active = #self.terminals
	self.win = nil

	return self
end

function M:new_terminal(active, opts)
	opts = vim.tbl_deep_extend("force", self.opts.terminal, opts or {})

	local term = terminal.new(opts)
	self.terminals[#self.terminals + 1] = term

	if active then self.active = #self.terminals end
end

function M:open()
	local term = self.terminals[self.active]
	if not term.job_id then term:spawn() end

	if self.win and vim.api.nvim_win_is_valid(self.win) then
		ui.open_term(term.buf, self.win)
	else
		self.win = ui.open_win(term.buf, self.opts)
	end

	ui.set_winbar(self)
end

function M:next()
	self.active = (self.active % #self.terminals) + 1
	ui.set_winbar(self)
end

function M:prev()
	self.active = ((self.active - 2) % #self.terminals) + 1
	ui.set_winbar(self)
end

return M
