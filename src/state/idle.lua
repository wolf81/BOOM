--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Idle = Class { __includes = StateBase }

function Idle:enter()
	StateBase.enter(self)

	self.entity:animate('idle')
end
