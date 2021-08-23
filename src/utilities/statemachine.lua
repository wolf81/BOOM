local StateMachine = {}
StateMachine.__index = StateMachine

function StateMachine:new(states)
	local empty = {
		draw = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end,
	}

	return setmetatable({
		_empty = empty,
		_states = states or {},
		_current = empty,
		_currentStateName = nil
	}, StateMachine)
end

function StateMachine:change(stateName, enterParams)
	for k,v in pairs(self._states) do
		print(k, tostring(v))
	end
	assert(self._states[stateName], 'state not defined: ' .. stateName)
	self._current:exit()
	self._current = self._states[stateName]()
	self._current:enter(enterParams)
	
	self._currentStateName = stateName
end

function StateMachine:update(dt)
	self._current:update(dt)
end

function StateMachine:draw()
	self._current:draw()
end

function StateMachine:currentStateName()
	return self._currentStateName
end

return setmetatable(StateMachine, {
	__call = StateMachine.new
})