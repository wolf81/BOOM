--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_remove, lume_randomchoice = lume.remove, lume.randomchoice

Creature = Class { __includes = { EntityBase, Movable, Destructable } }

function Creature:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 1.0
	self.z_index = def.z_index or 5

	self.category_flags = Category.MONSTER
	self.collision_flags = bit.bor(Category.PLAYER, Category.MONSTER, Category.TELEPORTER)
end

function Creature:config(id, x, y)
	EntityBase.config(self, id, x, y)

	self.control = CpuControl(self)

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['move'] = function() return Move(self) end,
		['destroy'] = function() return Destroy(self) end,
	}
	self.state_machine:change('idle')		
end

function Creature:update(dt)
	EntityBase.update(self, dt)

	self.control:update(dt)
	self.state_machine:update(dt)
end

function Creature:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Creature:idle()
	self.direction = Direction.NONE
	self.state_machine:change('idle')
end

function Creature:onCollision(entity)
	if not entity:is(Creature) then return end

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

function Creature:isIdling()
	return getmetatable(self.state_machine.current) == Idle
end
