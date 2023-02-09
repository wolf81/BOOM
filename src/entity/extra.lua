--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Extra = Class { __includes = EntityBase }

function Extra:config(id, x, y)
	EntityBase.config(self, id, x, y)

	self.flag = ExtraFlags.E

	self.category_flags = CategoryFlags.EXTRA
	self.collision_flags = CategoryFlags.PLAYER
end

function Extra:update(dt)
	EntityBase.update(self, dt)

	local frame_idx = self.animation:getCurrentFrame()

	if frame_idx <= 4 then
		self.flag = ExtraFlags.E
	elseif frame_idx <= 8 then
		self.flag = ExtraFlags.X
	elseif frame_idx <= 12 then
		self.flag = ExtraFlags.T
	elseif frame_idx <= 16 then
		self.flag = ExtraFlags.R
	elseif frame_idx <= 20 then
		self.flag = ExtraFlags.A
	else
		error('invalid frame index: ', frame_idx)
	end
end

function Extra:apply(player)
	assert(player ~= nil, 'player is required')
	SetFlag(player.extra_flags, self.flag)
end
