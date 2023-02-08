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

function Explosion:config(id, x, y, player, direction)
	EntityBase.config(self, id, x, y)

	assert(player ~= nil and getmetatable(player) == Player, 'player is required')

	self.player = player

	local anim_name = getAnimationName(direction)
	self:animate(anim_name)
	self.explode_time = self.animations[anim_name]:getDuration()
end

function Explosion:update(dt)
	EntityBase.update(self, dt)

	self.explode_time = math_max(self.explode_time - dt, 0)
	if self.explode_time == 0 then
		self.level:removeEntity(self)
	end
end
