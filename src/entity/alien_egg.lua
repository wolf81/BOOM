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

	self:idle()
end

function AlienEgg:update(dt)
	Projectile.update(self, dt)

	self.propel_delay = math_max(self.propel_delay - dt, 0)

	if self.propel_delay == 0 then
		self.state_machine:change('propel', self.direction)
	end
end
