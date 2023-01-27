--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

return function()
	local id = 0

	local next = function()
		id = id + 1
		return id
	end

	return {
		next = next,
	}
end
