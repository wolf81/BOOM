--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Player = Class { __includes = Creature }

function Player:init(def, x, y)
	Creature.init(self, def, x, y)
	
	self.z_index = 10
	self.control = PlayerControl(self)

	self.category_flags = Category.PLAYER
	self.collision_flags = bit.bor(Category.PLAYER, Category.COIN, Category.MONSTER, Category.TELEPORTER)
end
