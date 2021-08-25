Explode = Object:extend()

function Explode:enter(entity)
	local animationInfo = entity._data.states.explode.center.anim
	self._animation = Animation(entity, animationInfo)
end

function Explode:exit()
	-- body
end

function Explode:update(dt)
	self._animation:update(dt)
end

function Explode:draw()
	self._animation:draw()
end