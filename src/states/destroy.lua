Destroy = Object:extend()

function Destroy:enter(entity)
	self._entity = entity
	self._duration = entity._data.states.destroy.duration or 1.0

	local animationInfo = entity._data.states.destroy.anim
	self._animation = Animation(entity, animationInfo)
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