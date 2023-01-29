--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

Flash = Class { __includes = EntityBase }

function Flash:init(def)
	EntityBase.init(self, def)

	self.z_index = def.z_index or 20
	self.flash_time = self.animations['idle']:getDuration()
end

function Flash:update(dt)
	EntityBase.update(self, dt)

	self.flash_time = math_max(self.flash_time - dt, 0)

	if self.flash_time == 0 then
		self.level:removeEntity(self)
	end
end
