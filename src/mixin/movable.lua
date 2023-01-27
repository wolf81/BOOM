--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Movable = Class {}

function Movable:init()
	self.direction = Direction.NONE
end

function Movable:move(direction)
	self.direction = direction

	local state_name = direction == Direction.NONE and 'idle' or 'move'
	self.state_machine:change(state_name, direction)
end

function Movable:isMoving()
	return getmetatable(self.state_machine.current) == Move
end
