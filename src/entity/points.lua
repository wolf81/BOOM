--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

Points = Class { __includes = EntityBase }

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

function Points:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 30
	self.duration = 2.0
	self.alpha = 1.0
end

function Points:config(id, x, y, value)
	EntityBase.config(self, id, x, y)

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

function Points:update(dt)
	self.duration = math_max(self.duration - dt, 0)
	self.pos.y = self.pos.y - self.speed * dt

	EntityBase.update(self, dt)

	if self.duration == 0 then
		self:destroy()
	end
end
