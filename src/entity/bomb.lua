--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

Bomb = Class { __includes = EntityBase }

function Bomb:init(def)
	EntityBase.init(self, def)

	self.z_index = def.z_index or 1	
end

function Bomb:config(id, level, x, y, player)
	EntityBase.config(self, id, level, x, y)

	assert(player ~= nil and getmetatable(player) == Player, 'player is required')

	self.player = player
	self.fuse_time = self.player.fuse_time
end

function Bomb:update(dt)
	EntityBase.update(self, dt)

	self.fuse_time = math_max(self.fuse_time - dt, 0)
	if self.fuse_time == 0 then
		print('EXPLODE')
		self.level:removeEntity(self)
	end
end
