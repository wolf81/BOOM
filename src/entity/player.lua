--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min, math_max = math.min, math.max

local PLAYER_HP_MAX = 16

Player = Class { __includes = Creature }

local function setHitpoints(self, hp)
	self.hitpoints = math_max(math_min(hp, PLAYER_HP_MAX), 0)
	print('hp', self.hitpoints)
end

function Player:init(def)
	Creature.init(self, def)

	assert(def.fuse_time ~= nil and type(def.fuse_time) == 'number', 'fuse_time is required')

	self.fuse_time = def.fuse_time
	self.category_flags = Category.PLAYER
	self.collision_flags = bit.bor(Category.PLAYER, Category.COIN, Category.MONSTER, Category.TELEPORTER)
	self.hitpoints = 16

	self.bonus_info = { 
		[BonusType.PLAYER_HASTE] = { active = false, base_speed = self.speed, factor = 2 },
		[BonusType.PLAYER_SHIELD] = nil,
	}
end

function Player:config(id, x, y)
	Creature.config(self, id, x, y)

	self.control = PlayerControl(self)
end

function Player:hit()
	setHitpoints(self, self.hitpoints - 1)
	if self.hitpoints == 0 then
		self:destroy()
	else
		Creature.hit(self)
	end
end

function Player:healAll()
	setHitpoints(self, PLAYER_HP_MAX)
end

function Player:healOne()
	setHitpoints(self, self.hitpoints + 2)
end

function Player:haste()
	local factor = 2

	local haste_bonus = self.bonus_info[BonusType.PLAYER_HASTE]
	haste_bonus.active = true

	self.speed = haste_bonus.base_speed * haste_bonus.factor

	Timer.after(10, function()
		haste_bonus.active = false
		self.speed = haste_bonus.base_speed
	end)
end

function Player:shield()
	-- body
end
