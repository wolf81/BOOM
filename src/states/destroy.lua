Destroy = Object:extend()

function Destroy:enter(entity)
	self._entity = entity	

	local animationInfo = entity._data.states.destroy.anim or {
		["duration"] = -1,
	}

	self._animation = Animation(entity, animationInfo)
	self._duration = self._animation:duration()
end

function Destroy:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self._entity:remove()
	end
end

function Destroy:draw()
	self._animation:draw()
end