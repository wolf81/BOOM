Move = Object:extend()

function Move:enter(entity)
	self._entity = entity

	local dir = self._entity:direction()

	if dir == Direction.UP then	
		local animationInfo = self._entity._data.states.move.up.anim
		self._animation = Animation(self._entity, animationInfo)
	elseif dir == Direction.DOWN then
		local animationInfo = self._entity._data.states.move.down.anim
		self._animation = Animation(self._entity, animationInfo)		
	elseif dir == Direction.RIGHT then
		local animationInfo = self._entity._data.states.move.right.anim
		self._animation = Animation(self._entity, animationInfo)		
	elseif dir == Direction.LEFT then
		local animationInfo = self._entity._data.states.move.left.anim
		self._animation = Animation(self._entity, animationInfo)		
	end
end

function Move:exit()
	-- body
end

function Move:update(dt)
	local dir = self._entity:direction()
	local pos = self._entity:position()
	local dxy = dir:permul(TileSize) * dt * self._entity:speed()
	pos = pos + dxy
	self._entity:setPosition(pos)

	self._animation:update(dt)
end

function Move:draw()
	self._animation:draw()
end