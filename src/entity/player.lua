--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min, math_max = math.min, math.max

local DAMAGE_SHIELD_DURATION = 1.5

Player = Class { __includes = Creature }

local function respawn(self)
	self.state_machine:change('idle')
	self.respawn_delay = 0
end

function Player:init(def)
	def.hitpoints = 16

	Creature.init(self, def)

	self.fuse_time = 5.0
	self.category_flags = CategoryFlags.PLAYER
	self.collision_flags = bit.bor(CategoryFlags.PLAYER, CategoryFlags.COIN, CategoryFlags.MONSTER, CategoryFlags.TELEPORTER)
	self.score = 0
	self.lives = 3
	self.extra_flags = 0
	self.bonus_flags = 0
	self.haste_duration = 0
	self.shield_duration = 0
	self.shield_delay = 0
	self.respawn_delay = 0

	self.bomb_count = 0
	for i = 1, 5 do self:addBomb() end

	self.base_speed = self.speed
	self.shield = nil
end

function Player:destroy()
	if not self:isDestroyed() then
		self.lives = math_max(self.lives - 1, 0)
		Signal.remove(self.on_destroy_handle, Notifications.ON_DESTROY_BOMB)

		if self.lives > 0 then
			self.respawn_delay = 3.0
		end
	end

	Creature.destroy(self)
end

function Player:config(id, x, y)
	Creature.config(self, id, x, y)

	self.control = PlayerControl(self)

	self.on_destroy_handle = Signal.register(Notifications.ON_DESTROY_BOMB, function(bomb)
		if bomb.player_id == self.id then
			self.bomb_count = self.bomb_count + 1
		end
	end)
end

function Player:serialize()
	local obj = Creature.serialize(self)
	obj.score = self.score
	obj.bomb_count = self.bomb_count
	obj.shield_delay = self.shield_delay
	obj.shield_duration = self.shield_duration
	obj.haste_duration = self.haste_duration
	obj.respawn_delay = self.respawn_delay
	obj.lives = self.lives
	obj.extra_flags = self.extra_flags
	obj.bonus_flags = self.bonus_flags
	return obj
end

function Player.deserialize(obj)
	local player = Creature.deserialize(obj)
	player.score = obj.score
	player.bomb_count = obj.bomb_count
	player.shield_delay = obj.shield_delay
	player.shield_duration = obj.shield_duration
	player.haste_duration = obj.haste_duration
	player.respawn_delay = obj.respawn_delay
	player.lives = obj.lives
	player.extra_flags = obj.extra_flags
	player.bonus_flags = obj.bonus_flags

	if player.shield_duration > 0 then
		player:applyShield(player.shield_duration)
	end

	if player.haste_duration > 0 then
		player:applyHaste(player.haste_duration)
	end

	return player
end

function Player:hit(damage)
	if self.shield ~= nil then return end

	Creature.hit(self, damage)

	if self.hitpoints.current > 0 then
		if self.shield_delay == 0 then
			self.shield_delay = 0.05
		end
	elseif self.hitpoints.current == 0 then
		self.shield_delay = 0
		self.shield_duration = 0
		self.shield = nil
	end
end

function Player:update(dt)
	Creature.update(self, dt)

	if self.haste_duration > 0 then
		self.haste_duration = math_max(self.haste_duration - dt, 0)
		if self.haste_duration == 0 then
			self.speed = self.base_speed
			self.bonus_flags = ClearFlag(self.bonus_flags, BonusFlags.BOOTS)
			self.haste_duration = 0
		end
	end

	if self.shield_delay > 0 then
		self.shield_delay = math_max(self.shield_delay - dt, 0)
		if self.shield_delay == 0 then
			self:applyShield(DAMAGE_SHIELD_DURATION)
		end
	end

	if self.shield_duration > 0 then
		self.shield_duration = math_max(self.shield_duration - dt, 0)
		if self.shield_duration == 0 then
			self.shield = nil
			self.bonus_flags = ClearFlag(self.bonus_flags, BonusFlags.SHIELD)
			self.shield_duration = 0
		end
	end

	if self.respawn_delay > 0 then
		self.respawn_delay = math_max(self.respawn_delay - dt, 0)

		if self.respawn_delay == 0 then
			respawn(self)
		end
	end

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
	self.haste_duration = duration
end

function Player:applyShield(duration)
	assert(duration ~= nil and type(duration) == 'number', 'duration is required')
	self.shield = EntityFactory.create('shield', self.pos.x, self.pos.y, self, duration)
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.SHIELD)
	self.shield_duration = duration
end

function Player:addBomb()
	self.bonus_flags = SetFlag(self.bonus_flags, BonusFlags.EXTRA_BOMB)

	-- get current bomb count
	local bomb_count = GetMaskedValue(self.bonus_flags, BonusMasks.BOMB_COUNT, 12)
	bomb_count = math_min(bomb_count + 1, 8)
	-- reset bomb count to 0 in bonus flags
	local flags = ClearMask(self.bonus_flags, BonusMasks.BOMB_COUNT)
	-- set new bomb count
	self.bonus_flags = SetValue(flags, bomb_count, 12)
end

function Player:getBombCount()
	return self.bomb_count + GetMaskedValue(self.bonus_flags, BonusMasks.BOMB_COUNT, 12)
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
	if not self.level:getBomb(grid_pos) and self:getBombCount() > 0 then
		local x, y = grid_pos.x * TILE_W, grid_pos.y * TILE_H
		local range = 2 + self:getExplodeRange()
		local bomb = EntityFactory.create('bomb', x, y, self.id, self.fuse_time, range)
		self.level:addEntity(bomb)
		self.bomb_count = self.bomb_count - 1
	end
end
