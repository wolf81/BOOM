--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Teleporter = Class { __includes = EntityBase }

local function tryTeleport(self, entity)
	if entity:gridPosition() == self:gridPosition() then
		print('try teleport ' .. entity.name)
	end
end

function Teleporter:init(def)
	EntityBase.init(self, def)

	self.category_flags = Category.TELEPORTER
end

function Teleporter:config(id, x, y)
	EntityBase.config(self, id, x, y)

	self:setTarget(self)
end

function Teleporter:setTarget(teleporter)
	assert(teleporter ~= nil and getmetatable(teleporter) == Teleporter, 'target teleporter is required')
	self.target = teleporter
	self.queue = {}
end

function Teleporter:update(dt)
	EntityBase.update(self, dt)

	for _, entity in ipairs(self.level.monsters) do tryTeleport(self, entity) end
	for _, entity in ipairs(self.level.players) do tryTeleport(self, entity) end
end
