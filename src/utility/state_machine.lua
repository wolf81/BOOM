--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

StateMachine = Class {}

function StateMachine:init(states)
	self.empty = {
		draw = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
	}
	self.states = states or {} -- [name] -> [function that returns states]
	self.current = self.empty
end

function StateMachine:change(stateName, ...)
	assert(self.states[stateName], 'state does not exist: ' .. stateName)
	self.current:exit()
	self.current = self.states[stateName]()
	self.current:enter(...)
end

function StateMachine:update(dt)
	self.current:update(dt)
end

function StateMachine:draw()
	self.current:draw()
end
