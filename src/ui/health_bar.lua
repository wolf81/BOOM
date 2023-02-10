--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor, math_ceil = math.floor, math.ceil

HealthBar = Class {}

local function updateHealthBarTexture(self)
	local canvas = love.graphics.newCanvas(HUD_W, HUD_H / 4)

	canvas:renderTo(function()
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

		local full_hearts = math_floor(self.hitpoints / 2)
		local half_hearts = self.hitpoints % 2
		local empty_hearts = 8 - full_hearts - half_hearts

		local i, x, y = 0, 0, 0
		while i < full_hearts do
			y = i >= 4 and 18 or 0
			x = (i >= 4 and i - 4 or i) * 18
			love.graphics.draw(self.heart_icons, self.heart_quads[3], x, y)
			i = i + 1
		end

		if half_hearts > 0 then
			y = i >= 4 and 18 or 0
			x = (i >= 4 and i - 4 or i) * 18
			love.graphics.draw(self.heart_icons, self.heart_quads[2], x, y)
			i = i + 1
		end

		while empty_hearts > 0 do
			y = i >= 4 and 18 or 0
			x = (i >= 4 and i - 4 or i) * 18
			love.graphics.draw(self.heart_icons, self.heart_quads[1], x, y)
			empty_hearts = empty_hearts - 1
			i = i + 1
		end
	end)

	return canvas
end

function HealthBar:init()
	self.heart_icons = love.graphics.newImage('gfx/Heart Icons.png')
	self.heart_quads = GenerateQuads(self.heart_icons, 18, 18)

	self.hitpoints = 16
	self.canvas = updateHealthBarTexture(self)
end

function HealthBar:updateHitpoints(hitpoints)
	if self.hitpoints == hitpoints then return end

	self.hitpoints = hitpoints
	self.canvas = updateHealthBarTexture(self)
end

function HealthBar:draw(x, y)
	love.graphics.draw(self.canvas, x, y)
end
