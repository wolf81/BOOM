--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local Collider = require 'src.utility.collider'

Level = Class {}

local function onCollide(entity1, entity2)
	print('collide', entity1.name, entity2.name)
	if entity1:is(Creature) and entity2:is(Creature) then
		entity2:onCollision(entity1)
		entity1:onCollision(entity2)
	end
end

function Level:init(index, background, entities, grid, time)
	self.index = index
	self.background = background
	self.entities = entities
	self.grid = grid
	self.time = time

	self.collider = Collider(onCollide)

	print('level ' .. self.index)
	print(self.grid)

	for entity in self.entities:iterate() do
		-- give creatures a reference to the level, so
		-- they can check for blocked tiles when moving
		-- perhaps could move this to level loader?
		if entity:is(Creature) or entity:is(Player) then 
			entity:setLevel(self) 
		end

		-- TODO: not very efficient, but looks cleaner
		-- would be more efficient to add collider in 
		-- isCreature check above and seperate Coin & 
		-- Teleport check
		if entity:is(Creature) or entity:is(Player) then
			self.collider:add(entity)
		end
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
