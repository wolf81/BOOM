Fuse = Object:extend()

function Fuse:enter(entity)
	self._entity = entity

	local animationInfo = entity._data.states.fuse.anim
	self._animation = Animation(entity, animationInfo)
	self._duration = self._animation:duration()
end

function Fuse:exit()
	-- body
end

function Fuse:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self._entity:destroy()
	end
end

function Fuse:draw()
	self._animation:draw()
end