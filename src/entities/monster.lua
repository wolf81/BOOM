Monster = Creature:extend()

local function getRandomNoiseDelay()
	return love.math.random(7, 40)
end

function Monster:new(data)
	print('init monster')

	Monster.super.new(self, data)
end

function Monster:init(level, position)
	Monster.super.init(self, level, position)

	self._noiseDelay = getRandomNoiseDelay()
end

function Monster:update(dt)
	Monster.super.update(self, dt)

	self._noiseDelay = math.max(self._noiseDelay - dt, 0)
	if self._data.noise ~= nil and self._noiseDelay == 0 then
		AudioPlayer.playSound(self._data.noise)
		self._noiseDelay = getRandomNoiseDelay()
	end
end
