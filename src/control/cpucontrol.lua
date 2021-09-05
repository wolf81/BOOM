CpuControl = Object:extend()

function isPlayerInLOS(level, monster)
	local position = monster:position() + monster:spriteSize() / 2
	local direction = monster:direction()
	local lw, lh = level:getDimensions()

	local losFrame = Frame(0, 0, 0, 0)

	if direction == Direction.UP then
		losFrame = Frame(position.x, 0, 1, position.y)
	elseif direction == Direction.DOWN then
		losFrame = Frame(position.x, position.y, 1, lh - position.y)
	elseif direction == Direction.LEFT then
		losFrame = Frame(0, position.y, position.x, 1)
	elseif direction == Direction.RIGHT then
		losFrame = Frame(position.x, position.y, lw - position.x, 1)
	end

	for _, player in ipairs(level:players()) do
		if player:frame():intersects(losFrame) then
			return true
		end
	end

	return false
end

function CpuControl:new(level, monster)
	self._level = level
	self._monster = monster
	self._shootDelay = self._monster:shootDelay()
end

function CpuControl:update(dt)
	if self._monster:isDestroyed() then return false end

	self._shootDelay = math.max(self._shootDelay - dt, 0)

	if self._shootDelay == 0 and isPlayerInLOS(self._level, self._monster) then
		local success = self._monster:shoot()
		if success then
			self._shootDelay = self._monster:shootDelay()
		end
	end

	if not self._monster:isMoving() and not self._monster:isShooting() then
		local gridPos = self._monster:gridPosition()
		local position = self._monster:position()

		local directions = {}
		if position.x % TileSize.x == 0 then
			directions[#directions + 1] = Direction.UP
			directions[#directions + 1] = Direction.DOWN
		end

		if position.y % TileSize.y == 0 then
			directions[#directions + 1] = Direction.LEFT
			directions[#directions + 1] = Direction.RIGHT
		end

		directions = lume.shuffle(directions)

		for _, direction in ipairs(directions) do
			local nextGridPos = gridPos + direction
			if not self._level:isBlocked(nextGridPos) then
				self._monster:move(direction)
				return
			end
		end
	end
end