AnimationQueue = Object:extend()

function AnimationQueue:new(animations)
	self._animations = animations
	self._animationIndex = 1

	local duration = 0
	for _, animation in ipairs(animations) do
		duration = duration + animation:duration()
	end
	self._duration = duration
	
	self._time = 0
end

function AnimationQueue:duration()
	return self._duration
end

function AnimationQueue:update(dt)
	self._time = self._time + dt

	local animation = self._animations[self._animationIndex]
	animation:update(dt)

	if self._time > animation:duration() then
		if self._animationIndex < #self._animations then
		self._time = 0
			self._animationIndex = self._animationIndex + 1
		end
	end	
end

function AnimationQueue:draw()
	self._animations[self._animationIndex]:draw()
end
