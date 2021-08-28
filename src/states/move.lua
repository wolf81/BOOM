Move = State:extend()

function Move:enter(params)
	Move.super.enter(self, params)

	self._direction = self.entity:direction()

	if self.entity:isMoving() then
		if self._direction == Direction.DOWN or self._direction == Direction.RIGHT then
			self._toPosition = toPosition(toGridPosition(self.entity:position() + TileSize))		
		elseif self._direction == Direction.UP or self._direction == Direction.LEFT then
			self._toPosition = toPosition(toGridPosition(self.entity:position()))		
		end
	else
		self._toPosition = toPosition(self.entity:gridPosition() + self._direction)
	end

	if self._direction == Direction.UP then	
		local animationInfo = self.stateInfo.up.anim
		self._animation = Animation(self.entity, animationInfo)
	elseif self._direction == Direction.DOWN then
		local animationInfo = self.stateInfo.down.anim
		self._animation = Animation(self.entity, animationInfo)		
	elseif self._direction == Direction.RIGHT then
		local animationInfo = self.stateInfo.right.anim
		self._animation = Animation(self.entity, animationInfo)		
	elseif self._direction == Direction.LEFT then
		local animationInfo = self.stateInfo.left.anim
		self._animation = Animation(self.entity, animationInfo)		
	end
end

function Move:exit()
	-- body
end

function Move:update(dt)
	local dxy = self._direction:permul(TileSize) * dt * self.entity:speed()
	local pos = self.entity:position() + dxy

	if self._direction == Direction.RIGHT then
		pos.x = math.min(self._toPosition.x, pos.x)

		if pos.x == self._toPosition.x then
			self.entity:idle()
		end
	elseif self._direction == Direction.LEFT then
		pos.x = math.max(self._toPosition.x, pos.x)

		if pos.x == self._toPosition.x then
			self.entity:idle()
		end
	elseif self._direction == Direction.DOWN then
		pos.y = math.min(self._toPosition.y, pos.y)

		if pos.y == self._toPosition.y then
			self.entity:idle()
		end
	elseif self._direction == Direction.UP then
		pos.y = math.max(self._toPosition.y, pos.y)

		if pos.y == self._toPosition.y then
			self.entity:idle()
		end		
	end

	self.entity:setPosition(pos)

	self._animation:update(dt)
end

function Move:draw()
	self._animation:draw()
end
