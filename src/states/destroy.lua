Destroy = State:extend()

function Destroy:enter(params)
	Destroy.super.enter(self, params)

	local animationInfo = self.stateInfo.anim or {
		['duration'] = -1,
	}

	self._duration = self._animation:duration()
end

function Destroy:update(dt)
	Destroy.super.update(self, dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:remove()
	end
end
