--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

Destroy = Class { __includes = StateBase }

function Destroy:enter()
	StateBase.enter(self)

	self.duration = self.entity.animations['destroy']:getDuration()

	self.entity:animate('destroy')
	self.entity:playSound('destroy')
end

function Destroy:update(dt)
	self.duration = math_max(self.duration - dt, 0)

	if self.duration == 0 then
		self.entity.level:removeEntity(self.entity)
	end
end
