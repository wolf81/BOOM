--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, lume_remove, lume_randomchoice = math.max, lume.remove, lume.randomchoice

Monster = Class { __includes = Creature }

function Monster:init(def)
	Creature.init(self, def)

	self.projectile = def.projectile

	self.category_flags = Category.MONSTER
	self.collision_flags = bit.bor(Category.PLAYER, Category.MONSTER, Category.TELEPORTER)
end

function Monster:config(id, x, y)
	Creature.config(self, id, x, y)

	self.attack_delay = 0

	self.control = CpuControl(self)
end

function Monster:update(dt)
	Creature.update(self, dt)

	self.attack_delay = math_max(self.attack_delay - dt, 0)

	self.control:update(dt)
end

function Monster:onCollision(entity)
	if not entity:is(Monster) then return end

	-- is entity horizontally or vertically aligned with tiles
	local is_y_aligned = self.pos.x % TILE_W == 0
	local is_x_aligned = self.pos.y % TILE_H == 0

	-- assume both x and y axis aligned with tiles
	local dirs = { Direction.UP, Direction.DOWN, Direction.LEFT, Direction.RIGHT }

	-- when moving across y axis exclude horizontal directions
	if is_y_aligned and not is_x_aligned then 
		dirs = { Direction.UP, Direction.DOWN }
	end

	-- when moving across x-axis exclude vertical directions
	if is_x_aligned and not is_y_aligned then
		dirs = { Direction.LEFT, Direction.RIGHT }
	end

	-- exclude direction towards collding entity
	local grid_pos1 = self:gridPosition()
	local grid_pos2 = entity:gridPosition()
	local dxy = grid_pos1 - grid_pos2
	if dxy.x == 1 then lume_remove(dirs, Direction.LEFT) end
	if dxy.y == 1 then lume_remove(dirs, Direction.UP) end
	if dxy.x == -1 then lume_remove(dirs, Direction.RIGHT) end
	if dxy.y == -1 then lume_remove(dirs, Direction.DOWN) end

	-- finally choose a random direction from remaining directions
	if #dirs > 0 then
		self:move(lume_randomchoice(dirs))
	end
end

function Monster:canAttack()
	return self.attack_delay == 0
end
