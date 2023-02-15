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

	self.category_flags = CategoryFlags.MONSTER
	self.collision_flags = bit.bor(CategoryFlags.PLAYER, CategoryFlags.MONSTER, CategoryFlags.TELEPORTER)

	local attack_info = def.attack or {}
	attack_info.rate = attack_info.rate or 0.0
	self.attack_rate = attack_info.rate
	self.projectile = attack_info.projectile
end

function Monster:config(id, x, y)
	Creature.config(self, id, x, y)

	self.attack_delay = 0

	self.control = CpuControl(self)
end

function Monster:serialize()
	local obj = Creature.serialize(self)
	obj.attack_delay = self.attack_delay
	return obj
end

function Monster.deserialize(obj)
	local monster = Creature.deserialize(obj)
	monster.attack_delay = obj.attack_delay
	return monster
end

function Monster:update(dt)
	Creature.update(self, dt)

	self.attack_delay = math_max(self.attack_delay - dt, 0)

	self.control:update(dt)
end

function Monster:destroy()
	if not self:isDestroyed() then
		self.collision_flags = 0

		if self.name == 'Alien' then
			local extra = EntityFactory.create('extra', self.pos.x, self.pos.y)
			self.level:addEntity(extra)
		end
	end

	Creature.destroy(self)
end

function Monster:attack()
	if self.attack_delay > 0 then return end

	self.attack_delay = self.attack_rate

	Creature.attack(self)
end

function Monster:canAttack()
	return self.attack_delay == 0
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

	-- exclude direction towards colliding entity
	local grid_pos1 = self:gridPosition()
	local grid_pos2 = entity:gridPosition()
	local dxy = grid_pos1 - grid_pos2
	if dxy.x == 1 then lume_remove(dirs, Direction.LEFT) end
	if dxy.y == 1 then lume_remove(dirs, Direction.UP) end
	if dxy.x == -1 then lume_remove(dirs, Direction.RIGHT) end
	if dxy.y == -1 then lume_remove(dirs, Direction.DOWN) end

	-- finally choose a random direction from remaining directions
	if #dirs > 0 then
		print(self.name)
		self:move(lume_randomchoice(dirs))
	end
end
