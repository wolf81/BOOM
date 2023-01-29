--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local Collider = require 'src.utility.collider'
local SkipList = require 'src.utility.skip_list'

Level = Class {}

local function coordToKey(pos)
  return pos.x + pos.y * 1e7
end

local function isCollidable(entity)
	return entity.category_flags ~= Category.NONE
end

local function onCollide(entity1, entity2)
	if entity1:is(Creature) and entity2:is(Creature) then
		entity2:onCollision(entity1)
		entity1:onCollision(entity2)
	elseif entity1:is(Coin) and entity2:is(Player) then
		entity1:destroy()
	elseif entity1:is(Player) and entity2:is(Coin) then
		entity2:destroy()
	elseif entity1:is(Explosion) then
		entity2:destroy()
	elseif entity2:is(Explosion) then
		entity1:destroy()
	end
end

function Level:init(index, background, grid, time)
	self.index = index
	self.background = background
	self.grid = grid
	self.time = time

	-- TODO: seems there's not much value in using SkipList at this point, perhaps
	-- just use a list for each entity type and render in appropriate order
	-- in that case we can remove the z_index from entities as well
	self.entities = SkipList.new(TILE_W * TILE_H)
	self.collider = Collider(onCollide)

	self.bomb_info = {}
	self.bblock_info = {}

	AudioPlayer.playMusic('mus/BOOM Music ' .. math.ceil(self.index / 10) .. '.wav')

	-- TODO: use shash module for collision checking, likely more efficient

	print('level ' .. self.index)
	print(self.grid)
end

function Level:addEntity(entity)
	self.entities:insert(entity)

	if entity:is(BreakableBlock) then
		self.bblock_info[coordToKey(entity:gridPosition())] = entity
	elseif entity:is(Bomb) then
		self.bomb_info[coordToKey(entity:gridPosition())] = entity
	end

	if isCollidable(entity) then
		self.collider:add(entity)
	end
end

function Level:removeEntity(entity)
	self.entities:delete(entity)

	if entity:is(BreakableBlock) then
		local grid_pos = entity:gridPosition()
		self.bblock_info[coordToKey(grid_pos)] = nil
		self.grid:unblock(grid_pos.x, grid_pos.y)
	elseif entity:is(Bomb) then
		self.bomb_info[coordToKey(entity:gridPosition())] = nil
	end

	if isCollidable(entity) then
		self.collider:remove(entity)
	end
end

function Level:getBreakableBlock(grid_pos)
	return self.bblock_info[coordToKey(grid_pos)]
end

function Level:getBomb(grid_pos)
	return self.bomb_info[coordToKey(grid_pos)]
end

-- TODO: should use a vector to align with getBreakableBlock(), getBomb()
function Level:isBlocked(x, y)
	return self.grid:isBlocked(x, y)
end

function Level:update(dt)
	for key, entity in self.entities:ipairs() do
		entity:update(dt)
	end

	self.collider:update()
end

function Level:draw()
	love.graphics.draw(self.background)

	for key, entity in self.entities:ipairs() do
		entity:draw()
	end
end
