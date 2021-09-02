CpuControl = Object:extend()

function isPlayerInLOS(level, monster)
	local position = monster:position() + monster:size() / 2
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
end

function CpuControl:update(dt)
	if self._monster:isDestroyed() then return false end

	if isPlayerInLOS(self._level, self._monster) then
		local success = self._monster:shoot()
	end
	
	if not self._monster:isMoving() and not self._monster:isShooting() then
		local gridPos = self._monster:gridPosition()

		local directions = {
			Direction.UP,
			Direction.DOWN,
			Direction.LEFT,
			Direction.RIGHT
		}
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