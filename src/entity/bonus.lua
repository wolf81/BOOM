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
	local keys = GetKeys(bonusFlagIconInfo)
	local bonus = keys[math_random(#keys)]
	return bonus, bonusFlagIconInfo[bonus]
end

function Bonus:init(def, flag)
	EntityBase.init(self, def)

	self.category_flags = CategoryFlags.BONUS
	self.collision_flags = CategoryFlags.PLAYER
	self.bonus_type = nil -- this value is set during config
	self.duration = 0
	self.value = 50
end

function Bonus:config(id, x, y, flag)
	EntityBase.config(self, id, x, y)

	assert(flag ~= nil and type(flag) == 'number', 'flag is required')
	local frame_idx = bonusFlagIconInfo[flag]

	self.bonus_type = flag
	self.animations['idle'].frames[1] = frame_idx
	self.animations['destroy'].frames[1] = frame_idx

	if self.bonus_type == BonusFlags.SHIELD or self.bonus_type == BonusFlags.BOOTS then
		self.duration = 20
	end
end

function Bonus:apply(player)
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
	elseif self.bonus_type == BonusFlags.EXTRA_BOMB then
		player:addBomb()
	elseif self.bonus_type == BonusFlags.SHORT_FUSE then
		player:setShortFuse()
	elseif self.bonus_type == BonusFlags.EXPLODE_SIZE then
		player:increaseExplodeRange()
	else
		error('not implemented', self.bonus_type)
	end
end
