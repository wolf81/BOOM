--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min, math_max, string_lower = math.min, math.max, string.lower

Move = Class { __includes = StateBase }

function Move:enter(direction)
	StateBase.enter(self)

	local grid_pos = self.entity:gridPosition()
	local to_grid_pos = grid_pos + (direction or vector.zero)

	if direction == nil then
		-- move to nearest grid position
		self.to_pos = grid_pos:permul(TILE_SIZE)
		if self.to_pos.x < self.entity.pos.x then
			direction = Direction.LEFT
		elseif self.to_pos.x > self.entity.pos.x then
			direction = Direction.RIGHT
		elseif self.to_pos.y < self.entity.pos.y then
			direction = Direction.UP
		elseif self.to_pos.y > self.entity.pos.y then
			direction = Direction.DOWN
		end

		if direction == nil then direction = Direction.DOWN end
	end


	if self.entity.level:isBlocked(to_grid_pos.x, to_grid_pos.y) then 
		self.to_pos = grid_pos:permul(TILE_SIZE)
	else
		-- move to grid position indicated by direction
		self.to_pos = to_grid_pos:permul(TILE_SIZE)
	end

	self.direction = direction

	self.entity:animate('move-' .. string_lower(GetDirectionName(self.direction)))
end

function Move:update(dt)
	local dxy = self.direction * dt * self.entity.speed
	local pos = self.entity.pos + dxy

	if self.direction == Direction.RIGHT then
		pos.x = math_min(self.to_pos.x, pos.x)
		if pos.x == self.to_pos.x then
			self.entity:idle()
		end
	end

	if self.direction == Direction.LEFT then
		pos.x = math_max(self.to_pos.x, pos.x)
		if pos.x == self.to_pos.x then
			self.entity:idle()
		end
	end
	
	if self.direction == Direction.DOWN then
		pos.y = math_min(self.to_pos.y, pos.y)
		if pos.y == self.to_pos.y then
			self.entity:idle()
		end
	end

	if self.direction == Direction.UP then
		pos.y = math_max(self.to_pos.y, pos.y)
		if pos.y == self.to_pos.y then
			self.entity:idle()
		end
	end

	self.entity.pos = pos
end
