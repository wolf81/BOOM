Idle = Object:extend()

function Idle:new()
	-- body
end

function Idle:enter(entity)
	self._stateInfo = entity._data.states.idle
	self._animation = Animation(entity)
end

function Idle:update(dt)
	self._animation:update(dt)
end

function Idle:draw()
	self._animation:draw()
end