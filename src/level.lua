Level = Class {}

-- TODO: use skip list for drawing entities based on z-position
-- see: https://love2d.org/wiki/Skip_list:Drawing_Order

function Level:init(index, background, entities, grid, time)
	self.index = index
	self.background = background
	self.entities = entities
	self.grid = grid
	self.time = time

	print('level ' .. self.index)
	print(self.grid)

	for _, entity in ipairs(self.entities) do
		if getmetatable(entity) == Player or getmetatable(entity) == Monster then
			entity.level = self
		end
	end
end

function Level:isBlocked(x, y)
	return self.grid:isBlocked(x, y)
end

function Level:update(dt)
	for _, entity in ipairs(self.entities) do
		entity:update(dt)
	end
end

function Level:draw()
	love.graphics.draw(self.background)

	for _, entity in ipairs(self.entities) do
		entity:draw()
	end
end
