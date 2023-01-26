local math_min, math_max = math.min, math.max

Move = Class { __includes = StateBase }

function Move:enter(direction)
	StateBase.enter(self)

	assert(direction ~= Direction.NONE, 'direction should be UP, DOWN, LEFT or RIGHT')

	self.direction = direction

	self.entity.animation = self.entity.animations['move-' .. string.lower(GetDirectionName(self.direction))]

	-- calculate target position - when we reach this position and if no direction set, we can change to idle state
	local to_pos = self.entity.pos + self.direction:permul(TILE_SIZE)
	self.to_pos = vector(lume.round(to_pos.x, TILE_W), lume.round(to_pos.y, TILE_H))
end

function Move:update(dt)
	local dxy = self.direction:permul(TILE_SIZE) * dt * self.entity.speed
	local pos = self.entity.pos + dxy

	if self.direction == Direction.RIGHT then
		pos.x = math_min(self.to_pos.x, pos.x)
		if pos.x == self.to_pos.x and self.entity.direction == Direction.NONE then
			self.entity:idle()
		end
	end

	if self.direction == Direction.LEFT then
		pos.x = math_max(self.to_pos.x, pos.x)
		if pos.x == self.to_pos.x and self.entity.direction == Direction.NONE then
			self.entity:idle()
		end
	end
	
	if self.direction == Direction.DOWN then
		pos.y = math_min(self.to_pos.y, pos.y)
		if pos.y == self.to_pos.y and self.entity.direction == Direction.NONE then
			self.entity:idle()
		end
	end

	if self.direction == Direction.UP then
		pos.y = math_max(self.to_pos.y, pos.y)
		if pos.y == self.to_pos.y and self.entity.direction == Direction.NONE then
			self.entity:idle()
		end
	end

	self.entity.pos = pos
end
