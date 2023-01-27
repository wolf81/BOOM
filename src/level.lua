--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Level = Class {}

function Level:init(index, background, entities, grid, time)
	self.index = index
	self.background = background
	self.entities = entities
	self.grid = grid
	self.time = time

	print('level ' .. self.index)
	print(self.grid)

	for entity in self.entities:iterate() do
		if getmetatable(entity) == Player or getmetatable(entity) == Monster then
			entity.level = self
		end
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
