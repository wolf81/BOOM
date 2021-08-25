Entity = Object:extend()

function Entity:new(data)
	self._data = data

	self._position = vector(1, 1)
	self._removed = false

	QuadCache:register(self, data.spriteSize)

	self._stateMachine = StateMachine({ 
		['idle'] = function() return Idle() end, 
		['move'] = function() return Move() end,
		['fuse'] = function() return Fuse() end,
		['explode'] = function() return Explode() end,
		['destroy'] = function() return Destroy() end,
	})
end

function Entity:isRemoved()
	return self._removed
end

function Entity:remove()
	self._removed = true
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

function Entity:setLevel(level)
	self._level = level
end

function Entity:level()
	return self._level
end

function Entity:gridPosition()
	local pos = self:position()
	return toGridPosition(pos)
end

function Entity:update(dt)
	self._stateMachine:update(dt)
end

function Entity:draw(offset)
	self._stateMachine:draw(offset)
end

function Entity:destroy()
	if self._stateMachine:currentStateName() == 'destroy' then return end
	
	self._stateMachine:change('destroy', self)
end

function Entity:idle()
	if self._stateMachine:currentStateName() == 'idle' then return end

	self._stateMachine:change('idle', self)
end
