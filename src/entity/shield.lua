--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, math_floor, string_lower, lume_round = math.max, math.floor, string.lower, lume.round

Shield = Class { __includes = EntityBase }

function Shield:config(id, x, y, player, duration)
	EntityBase.config(self, id, x, y)

	assert(player ~= nil, 'player is required')
	assert(duration ~= nil and type(duration) == 'number', 'duration is required')

	self.duration = duration
	self.alpha = 0.5
	self.player = player
end

function Shield:setDirection(direction)
	if self.direction ~= direction then
		self.direction = direction
		self:animate('move-' .. string_lower(GetDirectionName(self.direction)))	
	end
end

function Shield:update(dt)
	EntityBase.update(self, dt)

	self.pos = self.player.pos

	self.duration = math_max(self.duration - dt, 0)
	if self.duration == 0 then
		self.player:removeShield()
	elseif self.duration <= 1.5 then
		if math_floor(self.duration * 10) % 2 == 0 then
			self.alpha = 0.5
		else
			self.alpha = 0.0
		end
	end
end

function Shield:draw()
	love.graphics.setColor(1.0, 1.0, 1.0, self.alpha)
	EntityBase.draw(self)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end
