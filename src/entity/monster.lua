--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Monster = Class { __includes = Creature }

function Monster:init(def)
	Creature.init(self, def)

	self.category_flags = Category.MONSTER
	self.collision_flags = bit.bor(Category.PLAYER, Category.MONSTER, Category.TELEPORTER)
end

function Monster:config(id, x, y)
	Creature.config(self, id, x, y)

	self.control = CpuControl(self)
end

function Monster:update(dt)
	Creature.update(self, dt)

	self.control:update(dt)
end
