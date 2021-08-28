Destroy = State:extend()

function Destroy:enter(params)
	Destroy.super.enter(self, params)

	local animationInfo = self.stateInfo.anim or {
		['duration'] = -1,
	}

	self._animation = Animation(self.entity, animationInfo)
	self._duration = self._animation:duration()
end

function Destroy:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:remove()
	end
end

function Destroy:draw()
	self._animation:draw()
end