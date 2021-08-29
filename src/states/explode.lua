Explode = State:extend()

function Explode:enter(params)
	Explode.super.enter(self, params)

	self._duration = self._animation:duration()
end

function Explode:update(dt)
	Explode.super.update(self, dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:destroy()
	end
end
