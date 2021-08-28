Fuse = Object:extend()

function Fuse:enter(entity)
	self._entity = entity

	if entity._data.states.fuse.sound then
		AudioPlayer.playSound(entity._data.states.fuse.sound)
	end

	local animList = entity._data.states.fuse.anim
	local animations = {}
	for _, animationInfo in ipairs(animList) do 
		animations[#animations + 1] = Animation(entity, animationInfo)
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
		self._entity:destroy()
	end
end

function Fuse:draw()
	self._animation:draw()
end