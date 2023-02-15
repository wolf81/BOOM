--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, math_floor, lume_shuffle, table_remove = math.max, math.floor, lume.shuffle, table.remove

AlienBoss = Class { __includes = StrategyBase }

local EGG_DELAY = 5.0

local LAUNCH_OFFSET = {
	[Direction.DOWN] = vector(TILE_W * 2, TILE_H * 4 - 10),
	[Direction.UP] = vector(TILE_W * 2, 10),
	[Direction.LEFT] = vector(10, TILE_H + TILE_H_2),
	[Direction.RIGHT] = vector(TILE_W * 4 - 10, TILE_H + TILE_H_2),
}

function fireEgg(self, origin, direction)
	local egg = EntityFactory.create(
		self.entity.projectile,
		origin.x, origin.y,
		direction
	)
	self.entity.level:addEntity(egg)
end

local function tryMove(monster, directions, size)
	local dirs = lume_shuffle(directions)
	local dir = nil

	-- loop through each direction, finding the first unblocked direction
	while #dirs > 0 do
		local direction = table_remove(dirs)
		local to_grid_pos1 = monster:gridPosition() + direction
		local to_grid_pos2 = to_grid_pos1 + size
		if (not monster.level:isBlocked(to_grid_pos1.x, to_grid_pos1.y) and
			not monster.level:isBlocked(to_grid_pos2.x, to_grid_pos2.y)) then
			dir = direction
			break
		end
	end

	if dir then
		monster:move(dir)
	else
		monster:idle()
	end
end

function AlienBoss:init(entity)
	StrategyBase.init(self, entity)

	self.egg_delay = EGG_DELAY / 2
	self.launch_delay = 0.0

	-- the size of the alien on the grid
	self.alien_size = vector(
		math_floor(entity.size.x / TILE_W) - 1,
		math_floor(entity.size.y / TILE_H) - 1
	)

	self.entity.direction = Direction.RIGHT
end

function AlienBoss:update(dt)
	if self.entity:isDestroyed() then return end

	self.egg_delay = math_max(self.egg_delay - dt, 0)
	self.launch_delay = math_max(self.launch_delay - dt, 0)

	if self.launch_delay > 0 then return end

	if self.entity:isMoving() then return end

	if self.egg_delay == 0 then
		self.launch_delay = 1.0
		self.egg_delay = EGG_DELAY

		local pos = self.entity.pos
		local direction = GetOpposite(self.entity.direction)

		self.entity.direction = direction

		fireEgg(self, pos + LAUNCH_OFFSET[direction], direction)
	else
		local is_x_aligned = self.entity.pos.x % TILE_W == 0
		local is_y_aligned = self.entity.pos.y % TILE_H == 0

		if is_x_aligned and is_y_aligned then
			tryMove(self.entity, { Direction.UP, Direction.DOWN, Direction.LEFT, Direction.RIGHT }, self.alien_size)
		elseif is_x_aligned then
			tryMove(self.entity, { Direction.UP, Direction.DOWN }, self.alien_size)
		elseif is_y_aligned then
			tryMove(self.entity, { Direction.LEFT, Direction.RIGHT }, self.alien_size)
		end
	end
end
