--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Destructable = Class {}

function Destructable:destroy()
	self.state_machine:change('destroy')
end

function Destructable:isDestroyed()
	return getmetatable(self.state_machine.current) == Destroy	
end
