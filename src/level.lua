Level = Class {}

function Level:init(index, background, entities, map, time)
	self.index = index
	self.background = background
	self.entities = entities
	self.map = map
	self.time = time
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
