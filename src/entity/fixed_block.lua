--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

FixedBlock = Class { __includes = EntityBase }

function FixedBlock:init(def, x, y)
	EntityBase.init(self, def, x, y)
end
