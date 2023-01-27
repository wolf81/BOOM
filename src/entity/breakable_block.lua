--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

BreakableBlock = Class { __includes = EntityBase }

function BreakableBlock:init(def, x, y)
	EntityBase.init(self, def, x, y)
end
