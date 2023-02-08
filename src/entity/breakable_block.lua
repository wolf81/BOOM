--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_random, lume_weightedchoice = math.random, lume.weightedchoice

BreakableBlock = Class { __includes = Block }

local function tryAddBonus(self)
	local flag = lume_weightedchoice({
		[0] = 889,
		[BonusFlags.DESTROY_BLOCKS] = 3,
		[BonusFlags.DESTROY_MONSTERS] = 3,
		[BonusFlags.EXTRA_BOMB] = 15,
		[BonusFlags.SHORT_FUSE] = 15,
		[BonusFlags.EXPLODE_SIZE] = 15,
		[BonusFlags.HEAL_ONE] = 15,
		[BonusFlags.HEAL_ALL] = 15,
		[BonusFlags.SHIELD] = 15,
		[BonusFlags.BOOTS] = 15,		
	})

	if flag ~= 0 then
		self.level:addEntity(EntityFactory.create('bonus', self.pos.x, self.pos.y, flag))
	end
end

function BreakableBlock:config(id, x, y)
	Block.config(self, id, x, y)
end

function BreakableBlock:destroy()
	if not self:isDestroyed() then
		tryAddBonus(self)
	end

	Block.destroy(self)
end
