--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local bit_band = bit.band

ExtraBar = Class {}

local function updateExtraTexture(self)
	local canvas = love.graphics.newCanvas(HUD_W, 20)

	canvas:renderTo(function() 
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

		local draw_w = 14

		local quad_idx = bit_band(self.flags, ExtraFlags.E) ~= 0 and 2 or 1
		love.graphics.draw(self.extra_icons, self.extra_quads[quad_idx], draw_w * 0, 0)

		quad_idx = bit_band(self.flags, ExtraFlags.X) ~= 0 and 3 or 1
		love.graphics.draw(self.extra_icons, self.extra_quads[quad_idx], draw_w * 1, 0)

		quad_idx = bit_band(self.flags, ExtraFlags.T) ~= 0 and 4 or 1
		love.graphics.draw(self.extra_icons, self.extra_quads[quad_idx], draw_w * 2, 0)

		quad_idx = bit_band(self.flags, ExtraFlags.R) ~= 0 and 5 or 1
		love.graphics.draw(self.extra_icons, self.extra_quads[quad_idx], draw_w * 3, 0)

		quad_idx = bit_band(self.flags, ExtraFlags.A) ~= 0 and 6 or 1
		love.graphics.draw(self.extra_icons, self.extra_quads[quad_idx], draw_w * 4, 0)	
	end)

	return canvas
end

function ExtraBar:init()
	self.extra_icons = love.graphics.newImage('gfx/Extra Icons.png')
	self.extra_quads = GenerateQuads(self.extra_icons, 15, 15)

	self.flags = 0
	self.canvas = updateExtraTexture(self)
end

function ExtraBar:updateExtraFlags(flags)
	if self.flags == flags then return end

	self.flags = flags
	self.canvas = updateExtraTexture(self)
end

function ExtraBar:draw(x, y)
	love.graphics.draw(self.canvas, x, y)
end
