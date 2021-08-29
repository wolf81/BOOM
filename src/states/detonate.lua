Detonate = State:extend()

function Detonate:enter(params)
	Detonate.super.enter(self, params)

	self._duration = self._animation:duration()
end

function Detonate:update(dt)
	Detonate.super.update(self, dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:destroy()
	end
end