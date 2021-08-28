Idle = State:extend()

function Idle:enter(params)
	Idle.super.enter(self, params)

	local animationInfo = self.stateInfo.anim or {
		['frames'] = {1, 1},
		['duration'] = 0.0,
	}

	self._animation = Animation(self.entity, animationInfo)
end

function Idle:update(dt)
	self._animation:update(dt)
end

function Idle:draw()
	self._animation:draw()
end