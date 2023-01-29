--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local Collider = require 'src.utility.collider'
local SkipList = require 'lib.skip_list.skip_list'

Level = Class {}

local function isCollidable(entity)
	return entity.category_flags ~= Category.NONE or entity.collision_flags ~= Category.NONE
end

local function onCollide(entity1, entity2)
	if entity1:is(Creature) and entity2:is(Creature) then
		entity2:onCollision(entity1)
		entity1:onCollision(entity2)
	elseif entity1:is(Coin) and entity2:is(Player) then
		entity1:destroy()
	elseif entity1:is(Player) and entity2:is(Coin) then
		entity2:destroy()
	end
end

function Level:init(index, background, grid, time)
	self.index = index
	self.background = background
	self.grid = grid
	self.time = time

	self.entities = SkipList:new()
	self.collider = Collider(onCollide)

	-- TODO: use shash for collision checking, likely more efficient

	print('level ' .. self.index)
	print(self.grid)
end

function Level:addEntity(entity)
	self.entities:insert(entity)

	if isCollidable(entity) then
		self.collider:add(entity)
	end
end

function Level:removeEntity(entity)
	self.entities:delete(entity)

	if isCollidable(entity) then
		self.collider:remove(entity)
	end
end

function Level:isBlocked(x, y)
	return self.grid:isBlocked(x, y)
end

function Level:update(dt)
	self.collider:update()
	for entity in self.entities:iterate() do
		entity:update(dt)
	end
end

function Level:draw()
	love.graphics.draw(self.background)

	for entity in self.entities:iterate() do
		entity:draw()
	end
end
