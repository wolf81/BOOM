--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_keys, math_random = lume.keys, math.random

BonusType = {
	DESTROY_BLOCKS = 1,
	DESTROY_MONSTERS = 2,
	INC_BOMB_COUNT = 3,
	INC_BOMB_SPEED = 4,
	INC_EXPLOSION_SIZE = 5,
	PLAYER_HEAL_ONE = 6,
	PLAYER_HEAL_ALL = 7,
	TEMP_PLAYER_SHIELD = 8,
	TEMP_PLAYER_SPEED = 8,
}

Bonus = Class { __includes = EntityBase }

local function destroyBlocks(self)
	local delay = 0.0

	self.level:eachGridPosition(function(pos)
		local bblock = self.level:getBreakableBlock(pos)
		if bblock then Timer.after(delay, function() bblock:destroy() end) end
		delay = delay + 0.01
	end)
end

local function destroyMonsters(self)
	for _, monster in ipairs(self.level.monsters) do
		monster:destroy()
	end
end

local function getRandomBonus()
	local keys = lume_keys(BonusType)
	local bonus = keys[math_random(#keys)]
	return BonusType.DESTROY_MONSTERS, 2
	-- return bonus, BonusType[bonus]
end

function Bonus:init(def)
	EntityBase.init(self, def)

	self.category_flags = Category.BONUS
	self.collision_flags = Category.PLAYER
	self.bonus_type = nil -- this value is set during config
end

function Bonus:config(id, x, y)
	EntityBase.config(self, id, x, y)

	local bonus_type, bonus_idx = getRandomBonus()
	
	self.bonus_type = bonus_type
	self.animations['idle'].frames[1] = bonus_idx
	self.animations['destroy'].frames[1] = bonus_idx
end

function Bonus:apply(player)
	print('apply bonus', self.bonus_type)

	if self.bonus_type == BonusType.DESTROY_BLOCKS then
		destroyBlocks(self)
	elseif self.bonus_type == BonusType.DESTROY_MONSTERS then
		destroyMonsters(self)
	end
end
