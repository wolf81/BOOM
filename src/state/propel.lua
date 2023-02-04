--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local string_lower = string.lower

Propel = Class { __includes = StateBase }

function Propel:enter(angle)
	StateBase.enter(self)	

	assert(angle ~= nil, 'angle must be defined')

	self.velocity = angle * self.entity.speed
	self.direction = nil

	self.offset = vector.zero

	if angle == Direction.DOWN then
		self.direction = Direction.DOWN
		self.offset = vector((TILE_W - self.entity.proj_size) / 2, TILE_H)
	elseif angle == Direction.UP then
		self.direction = Direction.UP
		self.offset = vector((TILE_W - self.entity.proj_size) / 2, -self.entity.proj_size)		
	elseif angle == Direction.LEFT then
		self.direction = Direction.LEFT
		self.offset = vector(-self.entity.proj_size, TILE_H / 2)
	elseif angle == Direction.RIGHT then
		self.direction = Direction.RIGHT
		self.offset = vector(TILE_W, TILE_H / 2)
	end

	self.entity.pos = self.entity.pos + self.offset

	self.entity:animate('propel-' .. string_lower(GetDirectionName(angle)))
	self.entity:playSound('propel')
end

function Propel:exit()
	if self.direction == Direction.LEFT then
		self.entity.pos.y = self.entity.pos.y - self.offset.y + self.entity.proj_size
		self.entity.pos.x = self.entity.pos.x - self.entity.proj_size
	elseif self.direction == Direction.DOWN then
		self.entity.pos.x = self.entity.pos.x - self.offset.x + self.entity.proj_size / 2
	elseif self.direction == Direction.RIGHT then
		self.entity.pos.y = self.entity.pos.y - TILE_H / 2 + self.entity.proj_size
	elseif self.direction == Direction.UP then
		self.entity.pos.x = self.entity.pos.x - self.offset.x + self.entity.proj_size / 2
		self.entity.pos.y = self.entity.pos.y - self.entity.proj_size
	end
end

function Propel:update(dt)
	self.entity.pos = self.entity.pos + self.velocity * dt
end
