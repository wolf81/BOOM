--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_random = math.random

BreakableBlock = Class { __includes = Block }

function BreakableBlock:config(id, x, y)
	Block.config(self, id, x, y)

	if math_random(1, 5) == 5 then
		self.bonus = EntityFactory.create('bonus', x, y)
	end	
end

function BreakableBlock:destroy()
	if not self:isDestroyed() and self.bonus then
		self.level:addEntity(self.bonus)
	end

	Block.destroy(self)
end
