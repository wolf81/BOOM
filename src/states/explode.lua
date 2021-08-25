Explode = Object:extend()

function Explode:enter(entity)
	self._entity = entity
	self._duration = entity._data.states.explode.duration or 1.0

	local animationInfo = entity._data.states.explode.center.anim

	if self._entity:orientation() == Orientation.HORIZONTAL then
		print('use horiz anim')
		animationInfo = entity._data.states.explode.horizontal.anim
	elseif self._entity:orientation() == Orientation.VERTICAL then
		print('use verti anim')
		animationInfo = entity._data.states.explode.vertical.anim
	end

	self._animation = Animation(entity, animationInfo)
end

function Explode:exit()
	-- body
end

function Explode:update(dt)
	self._animation:update(dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self._entity:destroy()
	end
end

function Explode:draw()
	self._animation:draw()
end