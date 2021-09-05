Entity = Object:extend()

function Entity:new(data)
	self._data = data

	self._position = vector(1, 1)
	self._removed = false

	local size = data.spriteSize or { 32, 32 }
	self._size = vector(unpack(size))

	QuadCache:register(self, self._size)

	self._stateMachine = StateMachine({ 
		['idle'] = function() return Idle() end, 
		['move'] = function() return Move() end,
		['fuse'] = function() return Fuse() end,
		['detonate'] = function() return Detonate() end,
		['explode'] = function() return Explode() end,
		['destroy'] = function() return Destroy() end,
		['cheer'] = function() return Cheer() end,
		['shoot'] = function() return Shoot() end,
		['propel'] = function() return Propel() end,
	})
end

function Entity:size()
	return self._size
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

function Entity:init(level, position)
	self._level = level
	self:setPosition(position)
	self:idle()
end

function Entity:level()
	return self._level
end

function Entity:frame()
	return Frame(self._position.x, self._position.y, self._size.x, self._size.y)
end

function Entity:gridPosition()
	local pos = self:position()
	return toGridPosition(pos)
end

function Entity:update(dt)
	self._stateMachine:update(dt)
end

function Entity:draw()
	self._stateMachine:draw()
end

function Entity:destroy()
	if self._stateMachine:currentStateName() == 'destroy' then return false end

	local params = { entity = self, stateInfo = self._data.states.destroy }
	self._stateMachine:change('destroy', params)

	return true
end

function Entity:idling()
	return self._stateMachine:currentStateName() == 'idle'
end

function Entity:idle()
	if self._stateMachine:currentStateName() == 'idle' then return false end

	local params = { entity = self, stateInfo = self._data.states.idle }
	self._stateMachine:change('idle', params)

	return true
end
