--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Teleporter = Class { __includes = EntityBase }

function Teleporter:init(def)
	EntityBase.init(self, def)

	self.category_flags = CategoryFlags.TELEPORTER
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
		self.target.subject = entity

		-- prevent movement state updates while teleporting
		local dir = entity.direction
		entity:idle()
		entity.pos = self.target.pos
		entity:move(dir)

		self.level:addEntity(EntityFactory.create('flash', self.pos.x, self.pos.y))
		self.level:addEntity(EntityFactory.create('flash', self.target.pos.x, self.target.pos.y))
	end
end

function Teleporter:update(dt)
	EntityBase.update(self, dt)

	if self.subject and self.subject:gridPosition() ~= self:gridPosition() then
		self.subject = nil
	end
end
