Explosion = Entity:extend()

function Explosion:explode(orientation)
	local stateInfo = self._data.states.explode.center

	if orientation == Orientation.HORIZONTAL then
		stateInfo = self._data.states.explode.horizontal
	elseif orientation == Orientation.VERTICAL then
		stateInfo = self._data.states.explode.vertical
	end

	local params = { entity = self, stateInfo = stateInfo }
	
	self._stateMachine:change('explode', params)
end