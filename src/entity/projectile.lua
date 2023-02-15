--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Projectile = Class { __includes = EntityBase }

local function applyOffset(self)
	-- TODO: unless in destroy state, projectile can default to small size
	local offset = vector.zero
	if self.direction == Direction.DOWN then
		offset = vector((TILE_W - self.proj_size) / 2, TILE_H)
	elseif self.direction == Direction.UP then
		offset = vector((TILE_W - self.proj_size) / 2, -self.proj_size)
	elseif self.direction == Direction.LEFT then
		offset = vector(-self.proj_size, TILE_H / 2)
	elseif self.direction == Direction.RIGHT then
		offset = vector(TILE_W, TILE_H / 2)
	end
	self.offset = offset

	self.pos = self.pos + self.offset
end

local function revertOffset(self)
	if self.direction == Direction.LEFT then
		self.pos.y = self.pos.y - self.offset.y + self.proj_size
		self.pos.x = self.pos.x - self.proj_size
	elseif self.direction == Direction.DOWN then
		self.pos.x = self.pos.x - self.offset.x + self.proj_size / 2
	elseif self.direction == Direction.RIGHT then
		self.pos.y = self.pos.y - TILE_H / 2 + self.proj_size
	elseif self.direction == Direction.UP then
		self.pos.x = self.pos.x - self.offset.x + self.proj_size / 2
		self.pos.y = self.pos.y - self.proj_size
	end
end

local function getProjectileFrameFunc(self)
	return self.pos.x, self.pos.y, self.proj_size, self.proj_size
end

function Projectile:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 75
	self.proj_size = def.size or 1
	self.damage = def.damage or 1

	self.category_flags = CategoryFlags.PROJECTILE
	self.collision_flags = bit.bor(CategoryFlags.BREAKABLE_BLOCK, CategoryFlags.FIXED_BLOCK, CategoryFlags.PLAYER, CategoryFlags.MONSTER)
end

function Projectile:config(id, x, y, direction)
	EntityBase.config(self, id, x, y)

	self.state_machine:change('propel', direction)

	self.direction = direction
	self.defaultFrameFunc = self.getFrame
	self.getFrame = getProjectileFrameFunc

	applyOffset(self)
end

function Projectile:serialize()
	local obj = EntityBase.serialize(self)
	obj.direction = { self.direction:unpack() }
	obj.offset = { self.offset:unpack() }
	return obj
end

function Projectile.deserialize(obj)
	local direction = vector(unpack(obj.direction))
	local projectile = EntityBase.deserialize(obj, direction)
	projectile.pos = vector(unpack(obj.pos))
	projectile.offset = vector(unpack(obj.offset))
	return projectile
end

function Projectile:hit(entity)
	EntityBase.hit(self, entity)

	self:destroy()
end

function Projectile:destroy()
	if not self:isDestroyed() then
		self.collision_flags = 0
		revertOffset(self)
	end

	EntityBase.destroy(self)

	self.getFrame = self.defaultFrameFunc
end
