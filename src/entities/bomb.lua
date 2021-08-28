Bomb = Entity:extend()

function Bomb:fuse()
	local params = { entity = self, stateInfo = self._data.states.fuse }
	self._stateMachine:change('fuse', params)
end

function Bomb:size()
	return self._data.size or 0
end