--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Strike = Class { __includes = EntityBase }

function Strike:init(damage)
	self.damage = damage or 1
end
