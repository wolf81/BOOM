Move = State:extend()

local function getAnimationInfo(direction, stateInfo)
	if direction == Direction.UP then return stateInfo.up.anim
	elseif direction == Direction.DOWN then return stateInfo.down.anim
	elseif direction == Direction.RIGHT then return stateInfo.right.anim
	elseif direction == Direction.LEFT then return stateInfo.left.anim
	end
end

function Move:enter(params)
	-- set proper animation for current direction
	params.stateInfo.anim = getAnimationInfo(params.entity:direction(), params.stateInfo)

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
end

function Move:update(dt)
	Move.super.update(self, dt)

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
end
