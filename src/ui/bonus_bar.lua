--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local bit_band = bit.band

BonusBar = Class {}

local function updateBonusTexture(self)
	local canvas = love.graphics.newCanvas(HUD_W, 20)

	canvas:renderTo(function() 
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

		local draw_w = 14

		local quad_idx = HasFlag(self.flags, BonusFlags.EXTRA_BOMB) and 1 or 6
		love.graphics.draw(self.bonus_icons, self.bonus_quads[quad_idx], draw_w * 0, 0)

		quad_idx = HasFlag(self.flags, BonusFlags.SHORT_FUSE) and 2 or 7
		love.graphics.draw(self.bonus_icons, self.bonus_quads[quad_idx], draw_w * 1, 0)

		quad_idx = HasFlag(self.flags, BonusFlags.EXPLODE_SIZE) and 3 or 8
		love.graphics.draw(self.bonus_icons, self.bonus_quads[quad_idx], draw_w * 2, 0)

		quad_idx = HasFlag(self.flags, BonusFlags.SHIELD) and 4 or 9
		love.graphics.draw(self.bonus_icons, self.bonus_quads[quad_idx], draw_w * 3, 0)

		quad_idx = HasFlag(self.flags, BonusFlags.BOOTS) and 5 or 10
		love.graphics.draw(self.bonus_icons, self.bonus_quads[quad_idx], draw_w * 4, 0)	
	end)

	return canvas
end

function BonusBar:init()
	self.bonus_icons = love.graphics.newImage('gfx/Bonus Icons.png')
	self.bonus_quads = GenerateQuads(self.bonus_icons, 15, 15)

	self.flags = 0
	self.canvas = updateBonusTexture(self)
end

function BonusBar:updateBonusFlags(flags)
	if self.flags == flags then return end

	self.flags = flags
	self.canvas = updateBonusTexture(self)
end

function BonusBar:draw(x, y)
	love.graphics.draw(self.canvas, x, y)
end
