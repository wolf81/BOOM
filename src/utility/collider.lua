--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local Collider = Class {}

local function checkCollision(x1, y1, w1, h1, x2, y2, h2, w2)
	return (
		x1 < x2 + w2 and
		x2 < x1 + w1 and
		y1 < y2 + h2 and
		y2 < y1 + h1
	)
end

function Collider:init(fn)
	assert(fn ~= nil and type(fn) == 'function', 'collision handler function required')

	self.on_collision = fn
	self.entities = {}
	self.entity_info = {}
end

function Collider:add(entity)
	table.insert(self.entities, entity)
	print('add', entity.name)
	self.entity_info[entity] = #self.entities
end

function Collider:remove(entity)
	local entity_idx = self.entity_info[entity]
	if entity_idx then
		self.entity_info[entity] = nil
		table.remove(self.entities, entity_idx)
	end
end

function Collider:update()
	-- TODO: the following algorithm is not very efficient and could become
	-- problematic when dealing with a large amount of collidable entities
	--
	-- we could improve the performance by creating cells that represent 
	-- smaller areas in the game world - we could track each entity in a cell
	-- and only perform collision checks for entities per cell
	--
	-- some entities might be in multiple cells at the same time when 
	-- standing on the border rectangle for the cell
	--
	-- also, it would be good to have collision categories or flags
	-- for example a player can collide with a coin, but a monster cannot
	-- there is no reason to check collisions between monsters and coins
	local last_idx = #self.entities
	while last_idx > 0 do
		local entity1 = self.entities[last_idx]
		local x1, y1, h1, w1 = entity1:getFrame()

		for idx = 1, last_idx - 1 do
			local entity2 = self.entities[idx]
			local x2, y2, h2, w2 = entity2:getFrame()

			if checkCollision(x1, y1, h1, w1, x2, y2, h2, w2) then
				self.on_collision(entity1, entity2)
			end
		end

		last_idx = last_idx - 1
	end
end

return Collider
