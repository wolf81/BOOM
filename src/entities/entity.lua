Entity = Object:extend()

function Entity:new()
	self._position = vector(1, 1)
end

function Entity:position()
	return self._position:clone()
end

function Entity:setPosition(position)
	self._position = position or vector(1, 1)
end

function Entity:update(dt)
	-- body
end

function Entity:draw()
	-- body
end