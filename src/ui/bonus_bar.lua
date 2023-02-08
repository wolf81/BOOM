--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local bit_band, bit_rshift = bit.band, bit.rshift

BonusBar = Class {}

local function updateBonusTexture(self)
	local canvas = love.graphics.newCanvas(HUD_W, 32)

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
			
		love.graphics.setFont(self.font)

		local bomb_count = bit_rshift(bit_band(self.flags, BonusMasks.BOMB_COUNT), 12)
		if bomb_count > 0 then
			love.graphics.print('x', 0, 8)
			love.graphics.print(bomb_count, 8, 8)
		end

		local explode_count = bit_rshift(bit_band(self.flags, BonusMasks.EXPLODE_COUNT), 15)
		if explode_count > 0 then
			love.graphics.print('x', 28, 8)
			love.graphics.print(explode_count, 36, 8)
		end
	end)

	return canvas
end

function BonusBar:init()
	self.bonus_icons = love.graphics.newImage('gfx/Bonus Icons.png')
	self.bonus_quads = GenerateQuads(self.bonus_icons, 15, 15)

	self.font = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 10)

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
