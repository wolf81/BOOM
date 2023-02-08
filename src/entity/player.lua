--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min, math_max = math.min, math.max

local DAMAGE_SHIELD_DURATION = 1.5

Player = Class { __includes = Creature }

local function repeatToggleFlag(self, flag, duration, delay)
	Timer.after(delay or 0, function()
		Timer.every(0.2, function()
			self.bonus_flags = ToggleMask(self.bonus_flags, flag)
		end, duration / 0.2)
	end)
end

local defaults = {}

function Player:init(def)
	def.hitpoints = 16

	Creature.init(self, def)

	assert(def.fuse_time ~= nil and type(def.fuse_time) == 'number', 'fuse_time is required')

	self.fuse_time = def.fuse_time
	self.category_flags = CategoryFlags.PLAYER
	self.collision_flags = bit.bor(CategoryFlags.PLAYER, CategoryFlags.COIN, CategoryFlags.MONSTER, CategoryFlags.TELEPORTER)
	self.score = 0
	self.lives = 3
	self.extra_flags = 0
	self.bonus_flags = 0

	self.base_speed = self.speed
	self.shield = nil

	self.damage_shield_timer = nil
end

function Player:config(id, x, y)
	Creature.config(self, id, x, y)

	self.control = PlayerControl(self)
end

function Player:hit(damage)
	if self.shield ~= nil then return end

	Creature.hit(self, damage)

	if self.hitpoints.current > 0 and not self.damage_shield_timer then
		self.damage_shield_timer = Timer.after(0.05, function() 
			self.shield = EntityFactory.create('shield', self.pos.x, self.pos.y, self, DAMAGE_SHIELD_DURATION)

			Timer.after(DAMAGE_SHIELD_DURATION, function()
				self.shield = nil
				Timer.cancel(self.damage_shield_timer)
				self.damage_shield_timer = nil
			end)
		end)
	elseif self.hitpoints.current == 0 then
		if self.damage_shield_timer then
			Timer.cancel(self.damage_shield_timer)
			self.damage_shield_timer = nil
		end
		self.shield = nil
	end
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

	Timer.after(duration, function()
		self.speed = self.base_speed
		self.bonus_flags = ClearFlag(self.bonus_flags, BonusFlags.BOOTS)		
	end)
end

function Player:applyShield(duration)
	assert(duration ~= nil and type(duration) == 'number', 'duration is required')
	self.shield = EntityFactory.create('shield', self.pos.x, self.pos.y, self, duration)
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.SHIELD)

	Timer.after(duration, function()
		self.shield = nil
		self.bonus_flags = ClearFlag(self.bonus_flags, BonusFlags.SHIELD)
	end)
end

function Player:addBomb()
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.EXTRA_BOMB)

	-- get current bomb count
	local bomb_count = GetMaskedValue(self.bonus_flags, BonusMasks.BOMB_COUNT, 12)
	bomb_count = math_min(bomb_count + 1, 5)
	-- reset bomb count to 0 in bonus flags
	local flags = ClearMask(self.bonus_flags, BonusMasks.BOMB_COUNT)
	-- set new bomb count
	self.bonus_flags = SetValue(flags, bomb_count, 12)
end

function Player:setShortFuse()
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.SHORT_FUSE)
end

function Player:getExplodeRange()
	return GetMaskedValue(self.bonus_flags, BonusMasks.EXPLODE_COUNT, 15)
end

function Player:getFuseDuration()
	if HasFlag(self.bonus_flags, BonusFlags.SHORT_FUSE) then
		return self.fuse_time - 2.0
	else
		return self.fuse_time
	end
end

function Player:increaseExplodeRange()
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.EXPLODE_SIZE)

	-- get current explode count
	local explode_count = GetMaskedValue(self.bonus_flags, BonusMasks.EXPLODE_COUNT, 15)
	explode_count = math_min(explode_count + 1, 2)
	-- reset explode count to 0 in bonus flags
	local flags = ClearMask(self.bonus_flags, BonusMasks.EXPLODE_COUNT)
	-- set new explode count
	self.bonus_flags = SetValue(flags, explode_count, 15)
end

function Player:tryDropBomb()
	local grid_pos = self:gridPosition()
	if not self.level:getBomb(grid_pos) then
		local x, y = grid_pos.x * TILE_W, grid_pos.y * TILE_H
		local bomb = EntityFactory.create('bomb', x, y, self)
		self.level:addEntity(bomb)
	end
end
