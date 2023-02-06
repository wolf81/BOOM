--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Shield = Class { __includes = EntityBase }

function Shield:draw()
	love.graphics.setColor(1.0, 1.0, 1.0, 0.5)
	EntityBase.draw(self)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end