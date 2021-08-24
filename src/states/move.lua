Move = Object:extend()

function Move:enter(entity)
	self._entity = entity
	self._direction = entity:direction()

	if self._entity:isMoving() then
		if self._direction == Direction.DOWN or self._direction == Direction.RIGHT then
			self._toPosition = toPosition(toGridPosition(self._entity:position() + TileSize))		
		elseif self._direction == Direction.UP or self._direction == Direction.LEFT then
			self._toPosition = toPosition(toGridPosition(self._entity:position() - TileSize))		
		end
	else
		self._toPosition = toPosition(self._entity:gridPosition() + self._direction)
	end

	if self._direction == Direction.UP then	
		local animationInfo = self._entity._data.states.move.up.anim
		self._animation = Animation(self._entity, animationInfo)
	elseif self._direction == Direction.DOWN then
		local animationInfo = self._entity._data.states.move.down.anim
		self._animation = Animation(self._entity, animationInfo)		
	elseif self._direction == Direction.RIGHT then
		local animationInfo = self._entity._data.states.move.right.anim
		self._animation = Animation(self._entity, animationInfo)		
	elseif self._direction == Direction.LEFT then
		local animationInfo = self._entity._data.states.move.left.anim
		self._animation = Animation(self._entity, animationInfo)		
	end
end

function Move:exit()
	-- body
end

function Move:update(dt)
	local dxy = self._direction:permul(TileSize) * dt * self._entity:speed()
	local pos = self._entity:position() + dxy

	if self._direction == Direction.RIGHT then
		pos.x = math.min(self._toPosition.x, pos.x)

		if pos.x == self._toPosition.x then
			self._entity:idle()
		end
	elseif self._direction == Direction.LEFT then
		pos.x = math.max(self._toPosition.x, pos.x)

		if pos.x == self._toPosition.x then
			self._entity:idle()
		end
	elseif self._direction == Direction.DOWN then
		pos.y = math.min(self._toPosition.y, pos.y)

		if pos.y == self._toPosition.y then
			self._entity:idle()
		end
	elseif self._direction == Direction.UP then
		pos.y = math.max(self._toPosition.y, pos.y)

		if pos.y == self._toPosition.y then
			self._entity:idle()
		end		
	end

	self._entity:setPosition(pos)

	self._animation:update(dt)
end

function Move:draw()
	self._animation:draw()
end
