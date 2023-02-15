--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local string_lower = string.lower

Propel = Class { __includes = StateBase }

function Propel:enter(direction)
	StateBase.enter(self)

	assert(direction ~= nil, 'direction must be defined')

	self.direction = direction
	self.velocity = self.direction * self.entity.speed

	self.entity:animate('propel-' .. string_lower(GetDirectionName(self.direction) or 'down'))
	self.entity:playSound('propel')
end

function Propel:update(dt)
	self.entity.pos = self.entity.pos + self.velocity * dt
end
