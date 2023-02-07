--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_keys, math_random = lume.keys, math.random

BonusType = {
	LEVEL_DESTROY_BLOCKS = 1,
	LEVEL_DESTROY_MONSTERS = 2,
	PLAYER_INC_BOMB_COUNT = 3,
	PLAYER_INC_BOMB_SPEED = 4,
	PLAYER_INC_EXPLOSION_SIZE = 5,
	PLAYER_HEAL_ONE = 6,
	PLAYER_HEAL_ALL = 7,
	PLAYER_SHIELD = 8,
	PLAYER_HASTE = 9,
}

Bonus = Class { __includes = EntityBase }

local function getRandomBonus()
	local keys = lume_keys(BonusType)
	local bonus = keys[math_random(#keys)]
	return BonusType.PLAYER_SHIELD, 8
	-- return bonus, BonusType[bonus]
end

function Bonus:init(def)
	EntityBase.init(self, def)

	self.category_flags = CategoryFlags.BONUS
	self.collision_flags = CategoryFlags.PLAYER
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

	if self.bonus_type == BonusType.LEVEL_DESTROY_BLOCKS then
		self.level:destroyBlocks()
	elseif self.bonus_type == BonusType.LEVEL_DESTROY_MONSTERS then
		self.level:destroyMonsters()
	elseif self.bonus_type == BonusType.PLAYER_HEAL_ONE then
		player:healOne()
	elseif self.bonus_type == BonusType.PLAYER_HEAL_ALL then
		player:healAll()
	elseif self.bonus_type == BonusType.PLAYER_HASTE then
		player:applyHaste()
	elseif self.bonus_type == BonusType.PLAYER_SHIELD then
		player:applyShield()
	else
		error('not implemented', self.bonus_type)
	end
end
