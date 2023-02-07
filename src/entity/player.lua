--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min, math_max = math.min, math.max

local PLAYER_HP_MAX = 16
local DAMAGE_SHIELD_DURATION = 1.5

Player = Class { __includes = Creature }

local function setHitpoints(self, hp)
	self.hitpoints = math_max(math_min(hp, PLAYER_HP_MAX), 0)
	print('hp', self.hitpoints)
end

local function repeatToggleFlag(self, flag, duration, delay)
	Timer.after(delay or 0, function()
		Timer.every(0.2, function()
			self.bonus_flags = ToggleMask(self.bonus_flags, flag)
		end, duration / 0.2)
	end)
end

function Player:init(def)
	Creature.init(self, def)

	assert(def.fuse_time ~= nil and type(def.fuse_time) == 'number', 'fuse_time is required')

	self.fuse_time = def.fuse_time
	self.category_flags = CategoryFlags.PLAYER
	self.collision_flags = bit.bor(CategoryFlags.PLAYER, CategoryFlags.COIN, CategoryFlags.MONSTER, CategoryFlags.TELEPORTER)
	self.hitpoints = 16
	self.score = 0
	self.extra_flags = 0
	self.bonus_flags = 0

	self.base_speed = self.speed
	self.shield = nil
end

function Player:config(id, x, y)
	Creature.config(self, id, x, y)

	self.control = PlayerControl(self)
end

function Player:hit()
	if self.shield ~= nil then return end

	setHitpoints(self, self.hitpoints - 1)
	if self.hitpoints == 0 then
		self:destroy()
	else
		Creature.hit(self)
		Timer.after(0.1, function() 
			self.shield = EntityFactory.create('shield', self.pos.x, self.pos.y, self, DAMAGE_SHIELD_DURATION)

			Timer.after(DAMAGE_SHIELD_DURATION, function()
				self.shield = nil
			end)
		end)
	end
end

function Player:healAll()
	setHitpoints(self, PLAYER_HP_MAX)
end

function Player:healOne()
	setHitpoints(self, self.hitpoints + 2)
end

function Player:update(dt)
	Creature.update(self, dt)

	if self.shield ~= nil then
		self.shield:update(dt)
	end
end

function Player:draw()
	Creature.draw(self)

	if self.shield ~= nil then
		self.shield:draw()
	end
end

function Player:move(direction)
	Creature.move(self, direction)

	if self.shield then
		self.shield:setDirection(direction)
	end
end

function Player:applyHaste(duration)
	assert(duration ~= nil and type(duration) == 'number', 'duration is required')
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.BOOTS)
	self.speed = self.base_speed * 2

	repeatToggleFlag(self, BonusFlags.BOOTS_HIDDEN, 3.0, duration - 3.0)

	Timer.after(duration, function()
		self.speed = self.base_speed
		self.bonus_flags = ClearFlag(self.bonus_flags, BonusFlags.BOOTS)		
	end)
end

function Player:applyShield(duration)
	assert(duration ~= nil and type(duration) == 'number', 'duration is required')
	self.shield = EntityFactory.create('shield', self.pos.x, self.pos.y, self, duration)
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.SHIELD)

	repeatToggleFlag(self, BonusFlags.SHIELD_HIDDEN, 3.0, duration - 3.0)

	Timer.after(duration, function()
		self.shield:destroy()
		self.bonus_flags = ClearFlag(self.bonus_flags, BonusFlags.SHIELD)
	end)
end
