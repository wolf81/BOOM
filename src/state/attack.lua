--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, string_lower = math.max, string.lower

Attack = Class { __includes = StateBase }

function Attack:init(entity)
	StateBase.init(self, entity)
end

function Attack:enter()
	StateBase.enter(self)

	assert(self.entity.direction ~= Direction.NONE, 'direction must be UP, DOWN, LEFT or RIGHT')

	self.entity:animate('attack-' .. string_lower(GetDirectionName(self.entity.direction)))

	self.duration = self.entity.animation:getDuration()
end

function Attack:update(dt)
	self.duration = math_max(self.duration - dt, 0)

	if self.duration == 0 then 
		self.entity.attack_delay = 0.2
		self.entity:move(self.entity.direction) 
	end
end
