Explosion = Entity:extend()

function Explosion:explode()
	self._stateMachine:change('explode', self)
end

function Explosion:idle()
	self:explode()
end