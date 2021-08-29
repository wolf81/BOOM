Fuse = State:extend()

function Fuse:enter(params)
	Fuse.super.enter(self, params)

	self._animation = Animation(self.entity, self.stateInfo.anim)
	self._duration = self._animation:duration()
end

function Fuse:exit()
	-- body
end

function Fuse:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:detonate()
	end
end

function Fuse:draw()
	self._animation:draw()
end