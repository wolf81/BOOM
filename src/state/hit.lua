--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

Hit = Class { __includes = StateBase }

function Hit:enter()
	StateBase.enter(self)

	self.duration = self.entity.animations['hit']:getDuration()	

	self.direction = self.entity.direction

	self.entity:animate('hit')
	self.entity:playSound('hit')
end

function Hit:update(dt)
	self.duration = math_max(self.duration - dt, 0)

	if self.duration == 0 then
		self.entity:idle()
	end
end
