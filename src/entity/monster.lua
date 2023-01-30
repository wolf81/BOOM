--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

Monster = Class { __includes = Creature }

function Monster:init(def)
	Creature.init(self, def)

	self.category_flags = Category.MONSTER
	self.collision_flags = bit.bor(Category.PLAYER, Category.MONSTER, Category.TELEPORTER)
end

function Monster:config(id, x, y)
	Creature.config(self, id, x, y)

	self.attack_delay = 0

	self.control = CpuControl(self)
end

function Monster:update(dt)
	Creature.update(self, dt)

	self.attack_delay = math_max(self.attack_delay - dt, 0)

	self.control:update(dt)
end

function Monster:canAttack()
	return self.attack_delay == 0
end

