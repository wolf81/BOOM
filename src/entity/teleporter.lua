--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Teleporter = Class { __includes = EntityBase }

function Teleporter:init(def)
	EntityBase.init(self, def)

	self.category_flags = Category.TELEPORTER
end

function Teleporter:update(dt)
	for _, entity in ipairs(self.level.monsters) do
		if entity.pos == self.pos then
			print('TELEPORT')
		end
	end
	
	for _, entity in ipairs(self.level.players) do
		if entity.pos == self.pos then
			print('TELEPORT')
		end
	end
end
