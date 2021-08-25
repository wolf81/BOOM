Explosion = Entity:extend()

function Explosion:orientation()
	return self._orientation
end

function Explosion:explode(orientation)
	self._orientation = orientation
	
	self._stateMachine:change('explode', self)
end