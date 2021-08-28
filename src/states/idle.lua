Idle = State:extend()

function Idle:enter(params)
	Idle.super.enter(self, params)

	self._animation = Animation(self.entity, self.stateInfo.anim)
end

function Idle:update(dt)
	self._animation:update(dt)
end

function Idle:draw()
	self._animation:draw()
end