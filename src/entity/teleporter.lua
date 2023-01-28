--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Teleporter = Class { __includes = EntityBase }

function Teleporter:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.category_flags = Category.TELEPORTER
end
