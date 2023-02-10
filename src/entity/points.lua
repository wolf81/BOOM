--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, math_min = math.max, math.min

Points = Class { __includes = EntityBase }

function Points:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 30
	self.duration = 2.0
	self.alpha = 1.0
end

function Points:config(id, x, y)
	EntityBase.config(self, id, x - self.size.x / 2, y - self.size.y / 2)
end

function Points:update(dt)
	self.duration = math_max(self.duration - dt, 0)
	self.pos.y = self.pos.y - self.speed * dt
	self.alpha = math_min(self.duration / 0.5, 1.0)

	EntityBase.update(self, dt)

	if self.duration == 0 then
		self:destroy()
	end
end

function Points:draw()
	love.graphics.setColor(1, 1, 1, self.alpha)
	EntityBase.draw(self)
	love.graphics.setColor(1, 1, 1, 1)
end
