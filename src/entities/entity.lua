Entity = Object:extend()

function Entity:new(data)
	self._data = data

	self._position = vector(1, 1)
	self._removed = false

	self._spriteSize = data.spriteSize or { 32, 32 }

	QuadCache:register(self, self._spriteSize)

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

function Entity:frame()
	return Frame(self._position.x, self._position.y, self._spriteSize[1], self._spriteSize[2])
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

	local params = { entity = self, stateInfo = self._data.states.destroy }

	self._stateMachine:change('destroy', params)
end

function Entity:idle()
	if self._stateMachine:currentStateName() == 'idle' then return end

	local params = { entity = self, stateInfo = self._data.states.idle }

	self._stateMachine:change('idle', params)
end
