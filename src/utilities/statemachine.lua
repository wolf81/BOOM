StateMachine = Object:extend()

function StateMachine:new(states)
	self._empty = {
		draw = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end,
	}
	self._states = states or {}
	self._current = self._empty
	self._currentStateName = nil
end

function StateMachine:change(stateName, enterParams)
	assert(self._states[stateName], 'state not defined: ' .. stateName)
	
	self._current:exit()
	self._current = self._states[stateName]()
	self._current:enter(enterParams)
	
	self._currentStateName = stateName
end

function StateMachine:update(dt)
	self._current:update(dt)
end

function StateMachine:draw(offset)
	self._current:draw(offset)
end

function StateMachine:currentStateName()
	return self._currentStateName
end