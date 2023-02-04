--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

BreakableBlock = Class { __includes = Block }

function BreakableBlock:destroy()
	if not self:isDestroyed() then
		self.level:addEntity(EntityFactory.create('points', self.pos.x, self.pos.y, 10))	
	end

	EntityBase.destroy(self)
end
