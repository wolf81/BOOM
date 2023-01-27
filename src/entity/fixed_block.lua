--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

FixedBlock = Class { __includes = EntityBase }

function FixedBlock:init(def, x, y)
	EntityBase.init(self, def, x, y)
end

function EntityBase:draw()
	love.graphics.draw(self.image, self.quads[1], self.pos.x, self.pos.y)
end
