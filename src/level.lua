--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Level = Class {}

local function isBlock(entity)
	local entity_type = getmetatable(entity)
	return entity_type == FixedBlock or entity_type == BreakableBlock
end

-- FIXME: since Player is a subclass of Creature, we should be able to just
-- check if entity type is Creature without needing to check for Player
-- however it seems hump.class doesn't include that functionality
local function isCreature(entity)
	local entity_type = getmetatable(entity)
	return entity_type == Creature or entity_type == Player
end

function Level:init(index, background, entities, grid, time)
	self.index = index
	self.background = background
	self.entities = entities
	self.grid = grid
	self.time = time

	print('level ' .. self.index)
	print(self.grid)

	for entity in self.entities:iterate() do
		local entity_type = getmetatable(entity)

		-- give creatures a reference to the level, so
		-- they can check for blocked tiles when moving
		if isCreature(entity) then entity.level = self end
	end
end

function Level:isBlocked(x, y)
	return self.grid:isBlocked(x, y)
end

function Level:update(dt)
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
