--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min, math_max = math.min, math.max

Creature = Class { __includes = EntityBase }

local function setHitpoints(self, hp)
	self.hitpoints.current = math_max(math_min(hp, self.hitpoints.max), 0)
end

function Creature:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 30

	local hitpoints = def.hitpoints or 1
	self.hitpoints = { current = hitpoints, max = hitpoints}

	self.category_flags = CategoryFlags.MONSTER
	self.collision_flags = bit.bor(CategoryFlags.PLAYER, CategoryFlags.MONSTER, CategoryFlags.TELEPORTER)
end

function Creature:config(id, x, y)
	EntityBase.config(self, id, x, y)

	self.control = CpuControl(self)
end

function Creature:serialize()
	local obj = EntityBase.serialize(self)
	obj.speed = self.speed
	obj.hitpoints = self.hitpoints

	if self.direction then
		obj.dir = { self.direction.x, self.direction.y }
	end

	return obj
end

function Creature.deserialize(obj)
	local creature = EntityBase.deserialize(obj)
	creature.speed = obj.speed
	creature.hitpoints = obj.hitpoints

	if obj.dir then
		self.direction = vector(unpack(obj.dir))
	end

	return creature
end

function Creature:hit(damage)
	setHitpoints(self, self.hitpoints.current - damage)

	if self.hitpoints.current == 0 then
		self:destroy()
	else
		EntityBase.hit(self, damage)
	end
end

function Creature:healAll()
	setHitpoints(self, self.hitpoints.max)
end

function Creature:healOne()
	setHitpoints(self, self.hitpoints.current + 2)
end

function Creature:update(dt)
	EntityBase.update(self, dt)

	self.control:update(dt)
end
