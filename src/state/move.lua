local mmin, mmax = math.min, math.max

Move = Class { __includes = StateBase }

function Move:enter(direction)
	StateBase.enter(self)

	assert(direction ~= Direction.none, 'direction should be up, down, left or right')

	self.direction = direction

	self.entity.animation = self.entity.animations['move-' .. GetDirectionName(self.direction)]

	-- not sure why an offset is needed to correctly calculate target position for right and down
	local offset = (self.direction == Direction.right or Direction.down) and TILE_SIZE / 2 or vector.zero

	-- calculate target position - when we reach this position and if no direction set, we can change to idle state
	self.to_pos = ToWorldPosition(ToGridPosition(self.entity.pos + offset) + self.direction)
end

function Move:update(dt)
	local dxy = self.direction:permul(TILE_SIZE) * dt * self.entity.speed
	local pos = self.entity.pos + dxy

	if self.direction == Direction.right then
		pos.x = mmin(self.to_pos.x, pos.x)
		if pos.x == self.to_pos.x and self.entity.direction == Direction.none then
			self.entity:idle()
		end
	end

	if self.direction == Direction.left then
		pos.x = mmax(self.to_pos.x, pos.x)
		if pos.x == self.to_pos.x and self.entity.direction == Direction.none then
			self.entity:idle()
		end
	end
	
	if self.direction == Direction.down then
		pos.y = mmin(self.to_pos.y, pos.y)
		if pos.y == self.to_pos.y and self.entity.direction == Direction.none then
			self.entity:idle()
		end
	end

	if self.direction == Direction.up then
		pos.y = mmax(self.to_pos.y, pos.y)
		if pos.y == self.to_pos.y and self.entity.direction == Direction.none then
			self.entity:idle()
		end
	end

	self.entity.pos = pos
end
