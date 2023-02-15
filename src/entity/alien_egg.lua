--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

AlienEgg = Class { __includes = Projectile }

function AlienEgg:init(def)
	Projectile.init(self, def)
end

function AlienEgg:config(id, x, y, direction)
	Projectile.config(self, id, x, y, direction)

	self.propel_delay = self.animations['idle-down']:getDuration()

	self.pos = vector(x, y)
	self.offset = vector.zero

	self:idle()
end

function AlienEgg:update(dt)
	Projectile.update(self, dt)

	self.propel_delay = math_max(self.propel_delay - dt, 0)

	if self.propel_delay == 0 then
		self.state_machine:change('propel', self.direction)
	end
end

function AlienEgg:destroy()
	Projectile.destroy(self)

	local x, y = self.pos.x, self.pos.y

	if self.direction == Direction.UP then
		x = x - TILE_W - TILE_W_2
		y = y + TILE_H + TILE_H_2
	elseif self.direction == Direction.DOWN then
		x = x - TILE_W - TILE_W_2
		y = y - TILE_H_2
	elseif self.direction == Direction.LEFT then
		x = x + TILE_W * 2
		y = y - TILE_H * 2 - TILE_H_2
	elseif self.direction == Direction.RIGHT then
		x = x - TILE_W
		y = y - TILE_H - TILE_H_2
	end

	local egg_crack = EntityFactory.create('alien-egg-crack', x, y, self.direction)
	self.level:addEntity(egg_crack)
	egg_crack:destroy()
end
