--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local bit_band, lume_ripairs, table_remove = bit.band, lume.ripairs, table.remove

local Collider = Class {}

-- check collisions using axis-aligned bounding box (AABB)
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

	self.onCollision = fn
	self.entities = {}
end

function Collider:add(entity)
	self.entities[#self.entities + 1] = entity
end

function Collider:remove(entity)
	-- TODO: somehow using a lookup table for entity indices doesn't seem to
	-- work, but this loop could be slow if we have many entities 
	-- optimize later ...	
	for idx, e in lume_ripairs(self.entities) do
		if e.id == entity.id then
			table_remove(self.entities, idx)
			break
		end
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

			if bit_band(entity1.collision_flags, entity2.category_flags) ~= 0 then
				if checkCollision(x1, y1, h1, w1, x2, y2, h2, w2) then
					self.onCollision(entity1, entity2)
				end
			elseif bit_band(entity2.collision_flags, entity1.category_flags) ~= 0 then
				if checkCollision(x1, y1, h1, w1, x2, y2, h2, w2) then
					self.onCollision(entity2, entity1)
				end				
			end
		end

		last_idx = last_idx - 1
	end
end

return Collider
