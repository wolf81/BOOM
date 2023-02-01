--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

BreakableBlock = Class { __includes = Block }

function BreakableBlock:init(def)
	EntityBase.init(self, def)

	self.z_index = 3
end
