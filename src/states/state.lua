State = Object:extend()

function State:enter(params)
	self.entity = params.entity
	self.stateInfo = params.stateInfo

	if self.stateInfo.sound then
		AudioPlayer.playSound(self.stateInfo.sound)
	end

	self._animation = Animation(self.entity, self.stateInfo.anim)
	self._duration = self._animation:duration() or 0
end

function State:exit()
	-- body
end

function State:update(dt)
	self._duration = math.max(self._duration - dt, 0)

	self._animation:update(dt)
end

function State:draw()
	self._animation:draw()
end

function State:isFinished()
	return self._duration == 0
end