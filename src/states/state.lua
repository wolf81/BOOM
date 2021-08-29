State = Object:extend()

function State:enter(params)
	self.entity = params.entity
	self.stateInfo = params.stateInfo

	if self.stateInfo.sound then
		AudioPlayer.playSound(self.stateInfo.sound)
	end

	self._animation = Animation(self.entity, self.stateInfo.anim)
end

function State:exit()
	-- body
end

function State:update(dt)
	self._animation:update(dt)
end

function State:draw()
	self._animation:draw()
end