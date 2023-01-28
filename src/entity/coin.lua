--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Coin = Class { __includes = EntityBase }

function Coin:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
	}
	self.state_machine:change('idle')	
end

function Coin:update(dt)
	EntityBase.update(self, dt)

	self.state_machine:update(dt)
end

function Coin:changeState(name, ...)
	self.state_machine:change(name, ...)
end
