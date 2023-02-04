--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Points1K = Class { __includes = Points }

local VALUES_FRAME_INFO = {
	10,
	50,
	100,
	150,
	200, 
	300, 
	400, 
	500,
	600, 
	700, 
	800, 
	900,
	1000
}

function Points1K:config(id, x, y, value)
	Points.config(self, id, x, y)

	-- TODO: would it be better to use some kind of enum here?
	assert(value or nil and type(value) == 'number', 'value is required')

	for frame_idx, frame_value in ipairs(VALUES_FRAME_INFO) do
		if value == frame_value then
			self.animations['idle'].frames[1] = frame_idx
			self.animations['destroy'].frames[1] = frame_idx
			break
		end
	end
end
