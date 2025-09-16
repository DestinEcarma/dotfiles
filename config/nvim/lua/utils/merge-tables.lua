return function(...)
	local t = {}

	for _, ti in ipairs({ ... }) do
		if type(ti) ~= "table" then
			error("Expected a table, got " .. type(ti))
		end

		for k, v in pairs(ti) do
			ti[k] = v
		end
	end

	return t
end
