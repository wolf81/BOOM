Monster = Creature:extend()

local function getRandomNoiseDelay()
	return love.math.random(7, 40)
end

function Monster:new(data)
	Monster.super.new(self, data)
end

function Monster:init(level, position)
	Monster.super.init(self, level, position)

	self._noiseDelay = getRandomNoiseDelay()

	-- TODO: would be cleaner if the following is part of shoot state, but how 
	-- to access from CpuControl?
	self._shootDelay = -1
	if self._data.states.shoot then
		self._shootDelay = self._data.states.shoot.delay or 1.0
	end
end

function Monster:shootDelay()
	return self._shootDelay
end

function Monster:isShooting()
	return self._stateMachine:currentStateName() == 'shoot'
end

function Monster:shoot()
	if self._stateMachine:currentStateName() == 'shoot' then return false end

	local projectileInfo = self._data.states.shoot.projectile
	assert(projectileInfo ~= nil, "no projectile defined")

	local offset = vector(unpack(projectileInfo.offset or {0, 0}))
	local size = self:spriteSize()

	offset = size:permul(offset)
	offset = vector(math.floor(offset.x), math.floor(offset.y))
	local position = self:position() + offset

	local projectile = EntityFactory:create(self:level(), projectileInfo.id, position)
	projectile:setVelocity(self:direction())
	projectile:setOffset(offset)
	self:level():addProjectile(projectile)	

	local params = { entity = self, stateInfo = self._data.states.shoot, }
	self._stateMachine:change('shoot', params)

	return true
end

function Monster:update(dt)
	Monster.super.update(self, dt)

	self._noiseDelay = math.max(self._noiseDelay - dt, 0)
	if self._data.noise ~= nil and self._noiseDelay == 0 then
		AudioPlayer.playSound(self._data.noise)
		self._noiseDelay = getRandomNoiseDelay()
	end
end
