Projectile = Entity:extend()

function Projectile:new(data)
	Projectile.super.new(self, data)

	self._speed = data.speed or 1.0
	self._size = vector(unpack(data.size or { 1, 1 }))
end

function Projectile:speed()
	return self._speed
end

function Projectile:velocity()
	return self._velocity
end

function Projectile:setVelocity(velocity)
	self._velocity = velocity
end

function Projectile:idle()
	self:propel()
end

function Projectile:size()
	return self._size
end

function Projectile:isPropelling()
	return self._stateMachine:currentStateName() == 'propel'
end

function Projectile:propel()
	if self:isPropelling() then return false end

	local params = { entity = self, stateInfo = self._data.states.propel }
	self._stateMachine:change('propel', params)

	return true
end