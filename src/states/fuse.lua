Fuse = State:extend()

function Fuse:enter(params)
	Fuse.super.enter(self, params)

	self._duration = self._animation:duration()
end

function Fuse:update(dt)
	Fuse.super.update(self, dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:detonate()
	end
end
