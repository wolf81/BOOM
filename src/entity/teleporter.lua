--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Teleporter = Class { __includes = EntityBase }

function Teleporter:init(def)
	EntityBase.init(self, def)

	self.category_flags = Category.TELEPORTER
end

function Teleporter:config(id, x, y)
	EntityBase.config(self, id, x, y)

	self.busy = false
	self.subject = nil

	self:setTarget(self)
end

function Teleporter:setTarget(teleporter)
	assert(teleporter ~= nil and getmetatable(teleporter) == Teleporter, 'target teleporter is required')
	self.target = teleporter
end

function Teleporter:teleport(entity)
	if not self.subject and not self.target.busy then
		print(self:gridPosition(), '=>', self.target:gridPosition())
		self.target.subject = entity
		entity.pos = self.target.pos
	end
end

function Teleporter:update(dt)
	EntityBase.update(self, dt)

	if self.subject and self.subject:gridPosition() ~= self:gridPosition() then
		self.subject = nil
	end
end
