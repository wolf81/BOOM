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
