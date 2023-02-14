--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

StrategyBase = Class {}

function StrategyBase:init(entity)
	assert(entity ~= nil, 'entity is required')

	self.entity = entity
end

function StrategyBase:update(dt)
	-- body
end
