--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor, math_ceil = math.floor, math.ceil

Hud = Class {}

local function drawPlayerHud(self, player, idx)
	for y = 1, 2 do
		for x = 1, 4 do
			love.graphics.draw(self.heart_icons, self.heart_quads[3], x * 18 - 5, y * 18 + 50 + (idx - 1) * HUD_H / 2)
		end
	end
end

function Hud:init(level)
	assert(level ~= nil, 'level is required')

	self.level = level
	self.panel = love.graphics.newImage('gfx/Panel.png')

	-- TODO: add more letters from font texture
	local BIG_LETTER_FONT_GLYPHS = ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~'
	self.font = love.graphics.newImageFont('gfx/BigLettersFont.png', BIG_LETTER_FONT_GLYPHS)
	love.graphics.setFont(self.font)

	self.heart_icons = love.graphics.newImage('gfx/Heart Icons.png')
	self.heart_quads = GenerateQuads(self.heart_icons, 18, 18)
end

function Hud:update(dt)
	self.time = math_ceil(self.level.time)
end

function Hud:draw()
	love.graphics.draw(self.panel)

	local text_h = self.font:getHeight()
	local text_w = self.font:getWidth(self.time)
	love.graphics.print(self.time, math_floor((HUD_W - text_w) / 2), math_floor((HUD_H - text_h) / 2))

	for idx, player in ipairs(self.level.players) do
		drawPlayerHud(self, player, idx)
	end
end
