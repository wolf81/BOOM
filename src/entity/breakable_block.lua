--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

BreakableBlock = Class { __includes = { Block, Destructable } }

function BreakableBlock:init(def)
	EntityBase.init(self, def)

	self.z_index = 3
end

function BreakableBlock:config(id, level, x, y)
	EntityBase.config(self, id, level, x, y)

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['destroy'] = function() return Destroy(self) end,
	}
	self.state_machine:change('idle')	
end

function BreakableBlock:update(dt)
	self.state_machine:update(dt)
end
