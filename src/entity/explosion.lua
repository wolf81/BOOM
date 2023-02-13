--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, bit_bor = math.max

Explosion = Class { __includes = EntityBase }

local function getAnimationName(direction)
	if direction == Direction.UP or direction == Direction.DOWN then
		return 'vertical'
	elseif direction == Direction.LEFT or direction == Direction.RIGHT then
		return 'horizontal'
	else
		return 'center'
	end
end

function Explosion:init(def)
	EntityBase.init(self, def)

	self.category_flags = CategoryFlags.EXPLOSION
	self.collision_flags = bit.bor(CategoryFlags.MONSTER, CategoryFlags.PLAYER)
	self.damage = def.damage or 1
end

function Explosion:config(id, x, y, player_id, bomb_id, direction)
	EntityBase.config(self, id, x, y)

	assert(player_id ~= nil, 'player_id is required')
	assert(bomb_id ~= nil, 'bomb_id is required')

	self.player_id = player_id
	self.bomb_id = bomb_id
	self.direction = direction

	local anim_name = getAnimationName(direction)
	self:animate(anim_name)
	self.explode_time = self.animations[anim_name]:getDuration()
end

function Explosion:serialize()
	local obj = EntityBase.serialize(self)
	obj.player_id = self.player_id
	obj.explode_time = self.explode_time
	obj.bomb_id = self.bomb_id
	if self.direction then
		obj.direction = { self.direction:unpack() }
	end
	return obj
end

function Explosion.deserialize(obj)
	local direction = obj.direction and vector(unpack(obj.direction))
	local explosion = EntityBase.deserialize(obj, obj.player_id, obj.bomb_id, direction)
	explosion.explode_time = obj.explode_time
	return explosion
end

function Explosion:update(dt)
	EntityBase.update(self, dt)

	self.explode_time = math_max(self.explode_time - dt, 0)
	if self.explode_time == 0 then
		self.level:removeEntity(self)
	end
end
