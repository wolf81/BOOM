Entity = Object:extend()

function Entity:new(data)
	self._data = data

	self._position = vector(1, 1)

	QuadCache:register(self, data.spriteSize)

	self._stateMachine = StateMachine({ 
		['idle'] = function() return Idle(self) end, 
		['move'] = function() return Move(self) end,
	})
end

function Entity:texture()
	return self._data.texture
end

function Entity:position()
	return self._position
end

function Entity:setPosition(position)
	self._position = position or vector(1, 1)
end

function Entity:update(dt)
	self._stateMachine:update(dt)
end

function Entity:draw(offset)
	self._stateMachine:draw(offset)
end

function Entity:idle()
	self._stateMachine:change('idle', self)
end
