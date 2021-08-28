Explode = State:extend()

function Explode:enter(params)
	Explode.super.enter(self, params)

	if self.stateInfo.center.sound then
		AudioPlayer.playSound(self.stateInfo.center.sound)
	end

	local animationInfo = self.stateInfo.center.anim
	if self.entity:orientation() == Orientation.HORIZONTAL then
		animationInfo = self.stateInfo.horizontal.anim
	elseif self.entity:orientation() == Orientation.VERTICAL then
		animationInfo = self.stateInfo.vertical.anim
	end

	self._animation = Animation(self.entity, animationInfo)
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