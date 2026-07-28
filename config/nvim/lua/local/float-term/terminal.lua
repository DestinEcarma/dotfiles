local M = {}
M.__index = M

function M.new(opts)
	local self = setmetatable(opts, M)

	self.buf = vim.api.nvim_create_buf(false, false)
	self.cmd = self.cmd
	self.name = self.name or self.cmd
	self.job_id = nil

	return self
end

function M:spawn()
	vim.api.nvim_buf_call(self.buf, function()
		self.job_id = vim.fn.jobstart(self.cmd, {
			term = true,
			cwd = self.dir,
			env = self.env,

			-- TODO: consider adding the hanlders
			-- on_exit =
			-- on_stdout =
			-- on_stderr =
		})
	end)
end

return M
