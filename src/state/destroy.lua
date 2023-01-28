--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Destroy = Class { __includes = StateBase }

function Destroy:enter()
	StateBase.enter(self)	

	self.entity:animate('destroy')
end
