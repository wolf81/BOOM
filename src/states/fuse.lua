Fuse = State:extend()

function Fuse:enter(params)
	Fuse.super.enter(self, params)

	if self.stateInfo.sound then
		AudioPlayer.playSound(self.stateInfo.sound)
	end

	local animList = self.stateInfo.anim
	local animations = {}
	for _, animationInfo in ipairs(animList) do 
		animations[#animations + 1] = Animation(self.entity, animationInfo)
	end
	self._animation = AnimationQueue(animations)
	self._duration = self._animation:duration()
end

function Fuse:exit()
	-- body
end

function Fuse:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self.entity:destroy()
	end
end

function Fuse:draw()
	self._animation:draw()
end