Detonate = State:extend()

function Detonate:enter(params)
	Detonate.super.enter(self, params)

	self._animation = Animation(self.entity, self.stateInfo.anim)
	self._duration = self._animation:duration()
end

function Detonate:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:destroy()
	end
end

function Detonate:draw()
	self._animation:draw()
end