--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor = math.floor

Creature = Class { __includes = { EntityBase, Movable } }

function Creature:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.speed = def.speed or 1.0
	self.z_index = def.z_index or 5
	self.control = CpuControl(self)
end

function Creature:setLevel(level)
	self.level = level
	
	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')		
end

function Creature:update(dt)
	EntityBase.update(self, dt)

	self.control:update(dt)
	self.state_machine:update(dt)
end

function Creature:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Creature:idle()
	self.direction = Direction.NONE
	self.state_machine:change('idle')
end

function Creature:isIdling()
	return getmetatable(self.state_machine.current) == Idle
end
