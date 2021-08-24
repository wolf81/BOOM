Idle = Object:extend()

function Idle:new(entity)
	-- body
end

function Idle:enter(entity)
	local animationInfo = entity._data.states.idle.anim
	self._animation = Animation(entity, animationInfo)
end

function Idle:exit()
	-- body
end

function Idle:update(dt)
	self._animation:update(dt)
end

function Idle:draw()
	self._animation:draw()
end