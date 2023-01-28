--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

StateBase = Class {}

function StateBase:init(entity)
	self.entity = entity
end

function StateBase:enter(entity)
	-- body
end

function StateBase:exit()
	-- body
end

function StateBase:update(dt)
	-- body
end
