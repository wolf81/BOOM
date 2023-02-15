--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local string_lower = string.lower

Idle = Class { __includes = StateBase }

function Idle:enter()
	StateBase.enter(self)

	if self.entity.direction then
		self.entity:animate('idle-' .. string_lower(GetDirectionName(self.entity.direction)))
	else
		self.entity:animate('idle')
	end
end
