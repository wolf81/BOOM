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
end

function Monster:isShooting()
	return self._stateMachine:currentStateName() == 'shoot'
end

function Monster:shoot()
	if self._stateMachine:currentStateName() == 'shoot' then return false end

	local params = { entity = self, stateInfo = self._data.states.shoot }
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
