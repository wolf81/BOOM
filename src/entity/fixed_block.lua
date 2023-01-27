--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

FixedBlock = Class { __includes = EntityBase }

function FixedBlock:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.quad_offset = 0
end

function FixedBlock:draw()
	love.graphics.draw(self.image, self.quads[1 + self.quad_offset], self.pos.x, self.pos.y)
end
