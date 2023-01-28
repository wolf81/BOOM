--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Bomb = Class { __includes = EntityBase }

function Bomb:init(def)
	EntityBase.init(self, def)

	self.z_index = def.z_index or 1	
end

function Bomb:config(id, x, y)
	EntityBase.config(self, id, x, y)
end
