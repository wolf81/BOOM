Bomb = Entity:extend()

function Bomb:fuse()
	if self._stateMachine:currentStateName() == 'fuse' then return false end

	local params = { entity = self, stateInfo = self._data.states.fuse }
	self._stateMachine:change('fuse', params)

	return true
end

function Bomb:detonate()
	if self._stateMachine:currentStateName() == 'detonate' then return false end

	local params = { entity = self, stateInfo = self._data.states.detonate }
	self._stateMachine:change('detonate', params)

	return true
end

function Bomb:size()
	return self._data.size or 0
end