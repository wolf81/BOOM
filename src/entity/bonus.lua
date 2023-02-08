--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_keys, math_random = lume.keys, math.random

local bonusFlagIconInfo = {
	[BonusFlags.DESTROY_BLOCKS] = 1,
	[BonusFlags.DESTROY_MONSTERS] = 2,
	[BonusFlags.EXTRA_BOMB] = 3,
	[BonusFlags.SHORT_FUSE] = 4,
	[BonusFlags.EXPLODE_SIZE] = 5,
	[BonusFlags.HEAL_ONE] = 6,
	[BonusFlags.HEAL_ALL] = 7,
	[BonusFlags.SHIELD] = 8,
	[BonusFlags.BOOTS] = 9,
}

Bonus = Class { __includes = EntityBase }

local function getRandomBonus()
	local keys = lume_keys(bonusFlagIconInfo)
	local bonus = keys[math_random(#keys)]
	return bonus, bonusFlagIconInfo[bonus]
end

function Bonus:init(def)
	EntityBase.init(self, def)

	self.category_flags = CategoryFlags.BONUS
	self.collision_flags = CategoryFlags.PLAYER
	self.bonus_type = nil -- this value is set during config
	self.duration = 0
end

function Bonus:config(id, x, y)
	EntityBase.config(self, id, x, y)

	local bonus_flag, bonus_idx = getRandomBonus()
	
	self.bonus_type = bonus_type
	self.animations['idle'].frames[1] = bonus_idx
	self.animations['destroy'].frames[1] = bonus_idx

	if self.bonus_type == BonusFlags.SHIELD or self.bonus_type == BonusFlags.BOOTS then
		self.duration = 10
	end
end

function Bonus:apply(player)
	print('apply bonus', self.bonus_type)

	if self.bonus_type == BonusFlags.DESTROY_BLOCKS then
		self.level:destroyBlocks()
	elseif self.bonus_type == BonusFlags.DESTROY_MONSTERS then
		self.level:destroyMonsters()
	elseif self.bonus_type == BonusFlags.HEAL_ONE then
		player:healOne()
	elseif self.bonus_type == BonusFlags.HEAL_ALL then
		player:healAll()
	elseif self.bonus_type == BonusFlags.BOOTS then
		player:applyHaste(self.duration)
	elseif self.bonus_type == BonusFlags.SHIELD then
		player:applyShield(self.duration)
	else
		error('not implemented', self.bonus_type)
	end
end
