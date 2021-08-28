State = Object:extend()

function State:enter(params)
	self.entity = params.entity
	self.stateInfo = params.stateInfo

	if self.stateInfo and self.stateInfo.sound then
		AudioPlayer.playSound(self.stateInfo.sound)
	end
end

function State:exit()
	-- body
end

function State:update(dt)
	-- body
end

function State:draw()
	-- body
end