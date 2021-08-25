Animation = Object:extend()

function Animation:new(entity, animationInfo)
	self._entity = entity
	self._animationInfo = animationInfo
	self._duration = animationInfo.duration or -1.0
	self._iterate = animationInfo.iterate or 1.0

	if self._duration >= 0 then
		local texture, quads = QuadCache:get(entity, animationInfo.frames)
		self._texture = texture
		self._quads = quads

		self._frameDuration = self._duration / #quads
		self._frameIndex = 1
	end

	self._time = 0
end

function Animation:duration()
	return self._duration * self._iterate
end

function Animation:update(dt)
	if self._duration == -1 then return end

	self._time = self._time + dt

	if self._time < self._frameDuration then return end

	self._time = self._time % self._frameDuration
	
	self._frameIndex = self._frameIndex + 1

	if self._frameIndex > #self._quads then
		self._frameIndex = 1
	end
end

function Animation:draw()
	if self._duration == -1 then return end

	local pos = self._entity:position()
	local quad = self._quads[self._frameIndex]
	love.graphics.draw(self._texture, quad, pos.x, pos.y)
end