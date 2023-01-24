Level = Class {}

function Level:init(index, background, entities, map, time)
	self.index = index
	self.background = background
	self.entities = entities
	self.map = map
	self.time = time

	for _, entity in ipairs(entities) do
		if not self.player and getmetatable(entity) == Player then
			self.player = entity
		end
	end
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

function Level:keyreleased(key, code)
	if key == 'up' then
		self.player:changeState('move', 'up')
	elseif key == 'down' then
		self.player:changeState('move', 'down')
	elseif key == 'left' then
		self.player:changeState('move', 'left')
	elseif key == 'right' then
		self.player:changeState('move', 'right')
	else
		self.player:changeState('idle')		
	end
end