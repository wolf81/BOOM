--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local Collider = require 'src.utility.collider'

local table_insert, lume_remove = table.insert, lume.remove

Level = Class {}

local function isCollidable(entity)
	return entity.category_flags ~= Category.NONE
end

local function insertEntities(self)
	for _, entity in ipairs(self.insert_queue) do
		if entity:is(Explosion) then table_insert(self.explosions, entity)
		elseif entity:is(Bomb) then table_insert(self.bombs, entity)
		elseif entity:is(Block) then table_insert(self.fixed_blocks, entity)
		elseif entity:is(BreakableBlock) then table_insert(self.breakable_blocks, entity)
		elseif entity:is(Player) then table_insert(self.players, entity)
		elseif entity:is(Creature) then table_insert(self.monsters, entity)
		elseif entity:is(Teleporter) then table_insert(self.teleporters, entity)
		elseif entity:is(Coin) then table_insert(self.coins, entity)
		end
	end

	self.insert_queue = {}
end

local function removeEntities(self)
	for _, entity in ipairs(self.remove_queue) do
		if entity:is(Explosion) then lume_remove(self.explosions, entity)
		elseif entity:is(Bomb) then lume_remove(self.bombs, entity)
		elseif entity:is(Block) then lume_remove(self.fixed_blocks, entity)
		elseif entity:is(BreakableBlock) then 
			lume_remove(self.breakable_blocks, entity)
			local grid_pos = entity:gridPosition()
			self.grid:unblock(grid_pos.x, grid_pos.y)
		elseif entity:is(Player) then lume_remove(self.players, entity)
		elseif entity:is(Creature) then lume_remove(self.monsters, entity)
		elseif entity:is(Teleporter) then lume_remove(self.teleporters, entity)
		elseif entity:is(Coin) then lume_remove(self.coins, entity)
		end
	end

	self.remove_queue = {}
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

function Level:init(index, background, grid, time, entities)
	self.index = index
	self.background = background
	self.grid = grid
	self.time = time

	-- TODO: seems there's not much value in using SkipList at this point, perhaps
	-- just use a list for each entity type and render in appropriate order
	-- in that case we can remove the z_index from entities as well
	self.collider = Collider(onCollide)

	self.fixed_blocks = {}
	self.breakable_blocks = {}
	self.players = {}
	self.coins = {}
	self.bombs = {}
	self.explosions = {}
	self.teleporters = {}
	self.monsters = {}

	self.insert_queue = {}
	self.remove_queue = {}

	for _, entity in ipairs(entities) do self:addEntity(entity) end

	AudioPlayer.playMusic('mus/BOOM Music ' .. math.ceil(self.index / 10) .. '.wav')

	-- TODO: use shash module for collision checking, likely more efficient

	print('level ' .. self.index)
	print(self.grid)
end

function Level:addEntity(entity)
	table_insert(self.insert_queue, entity)

	entity.level = self

	if isCollidable(entity) then
		self.collider:add(entity)
	end
end

function Level:removeEntity(entity)
	table_insert(self.remove_queue, entity)

	if isCollidable(entity) then
		self.collider:remove(entity)
	end
end

function Level:getBreakableBlock(grid_pos)
	for _, entity in ipairs(self.breakable_blocks) do
		if entity:gridPosition() == grid_pos then return entity end
	end

	return nil
end

function Level:getBomb(grid_pos)
	for _, entity in ipairs(self.bombs) do
		if entity:gridPosition() == grid_pos then return entity end
	end

	return nil
end

-- TODO: use a vector instead of x, y coords to align with getBreakableBlock(), getBomb()
function Level:isBlocked(x, y)
	return self.grid:isBlocked(x, y)
end

function Level:update(dt)
	insertEntities(self)

	for _, entity in ipairs(self.teleporters) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.coins) do
		entity:update(dt)
	end	

	for _, entity in ipairs(self.bombs) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.explosions) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.monsters) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.players) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.fixed_blocks) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.breakable_blocks) do
		entity:update(dt)
	end

	self.collider:update()

	removeEntities(self)
end

function Level:draw()
	love.graphics.draw(self.background)

	for _, entity in ipairs(self.teleporters) do
		entity:draw()
	end

	for _, entity in ipairs(self.coins) do
		entity:draw()
	end	

	for _, entity in ipairs(self.bombs) do
		entity:draw()
	end

	for _, entity in ipairs(self.explosions) do
		entity:draw()
	end

	for _, entity in ipairs(self.monsters) do
		entity:draw()
	end

	for _, entity in ipairs(self.players) do
		entity:draw()
	end

	for _, entity in ipairs(self.fixed_blocks) do
		entity:draw()
	end

	for _, entity in ipairs(self.breakable_blocks) do
		entity:draw()
	end
end
