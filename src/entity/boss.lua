--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min = math.min

Boss = Class { __includes =  Creature }

local function configureStateMachine(self)
	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['destroy'] = function() return Destroy(self) end,
		['hit'] = function() return Hit(self) end,
		['attack'] = function() return Attack(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')
end

function Boss:config(id, x, y)
	Creature.config(self, id, x, y)

	print('boss', self.hitpoints.current, self.hitpoints.max)

	configureStateMachine(self)
end

function Boss:hit(damage)
	Creature.hit(self, math_min(damage, 1))
end

function Boss:canAttack() return
	false
end
