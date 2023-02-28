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

	assert(self.entity.direction ~= nil, 'direction must be UP, DOWN, LEFT or RIGHT')

	self.entity:animate('attack-' .. string_lower(GetDirectionName(self.entity.direction)))
	self.entity:playSound('attack')

	if self.entity.projectile ~= nil then
		local x, y = self.entity.pos.x, self.entity.pos.y

		local projectile = EntityFactory.create(self.entity.projectile, 0, 0, self.entity.direction)

		if self.entity.direction == Direction.LEFT then
			x = x - projectile.proj_size
		elseif self.entity.direction == Direction.RIGHT then
			x = x + self.entity.size.x
		elseif self.entity.direction == Direction.DOWN then
			y = y + self.entity.size.y
		elseif self.entity.direction == Direction.UP then
			y = y - projectile.proj_size
		end

		projectile.pos = vector(x, y)

		self.entity.level:addEntity(projectile)
	end

	self.duration = self.entity.animation:getDuration()
end

function Attack:update(dt)
	self.duration = math_max(self.duration - dt, 0)

	if self.duration == 0 then
		self.entity:idle()
	end
end
