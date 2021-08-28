Explosion = Entity:extend()

function Explosion:orientation()
	return self._orientation
end

function Explosion:explode(orientation)
	self._orientation = orientation

	local params = { entity = self, stateInfo = self._data.states.explode }
	
	self._stateMachine:change('explode', params)
end