return function(...)
	local t = {}

	for _, t in ipairs({ ... }) do
		if type(t) ~= "table" then
			error("Expected a table, got " .. type(t))
		end

		for k, v in pairs(t) do
			t[k] = v
		end
	end

	return t
end
