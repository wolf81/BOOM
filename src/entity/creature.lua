--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_remove, lume_randomchoice = lume.remove, lume.randomchoice

Creature = Class { __includes = EntityBase }

function Creature:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 30

	self.category_flags = Category.MONSTER
	self.collision_flags = bit.bor(Category.PLAYER, Category.MONSTER, Category.TELEPORTER)
end

function Creature:config(id, x, y)
	EntityBase.config(self, id, x, y)

	self.control = CpuControl(self)
end

function Creature:update(dt)
	EntityBase.update(self, dt)

	self.control:update(dt)
end
