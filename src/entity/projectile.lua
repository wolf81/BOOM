--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Projectile = Class { __includes = EntityBase }

local function getProjectileFrameFunc(self)
	return self.pos.x, self.pos.y, self.proj_size, self.proj_size
end

function Projectile:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 75
	self.proj_size = def.size or 1

	self.category_flags = Category.PROJECTILE
	self.collision_flags = bit.bor(Category.BREAKABLE_BLOCK, Category.FIXED_BLOCK, Category.PLAYER)
end

function Projectile:config(id, x, y, velocity)
	EntityBase.config(self, id, x, y)

	self.state_machine:change('propel', velocity)

	self.defaultFrameFunc = self.getFrame
	self.getFrame = getProjectileFrameFunc
end

function Projectile:destroy()
	EntityBase.destroy(self)

	self.getFrame = self.defaultFrameFunc	
end
