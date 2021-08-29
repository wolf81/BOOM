CpuControl = Object:extend()

function CpuControl:new(level, monster)
	self._level = level
	self._monster = monster
end

function CpuControl:update(dt)
	if self._monster:isDestroyed() then return false end
	
	if self._monster:isMoving() == false then
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