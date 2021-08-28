Explode = State:extend()

function Explode:enter(params)
	Explode.super.enter(self, params)

	self._animation = Animation(self.entity, self.stateInfo.anim)
	self._duration = self._animation:duration()
end

function Explode:exit()
	-- body
end

function Explode:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:destroy()
	end
end

function Explode:draw()
	self._animation:draw()
end