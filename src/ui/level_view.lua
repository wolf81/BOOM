--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_ceil = math.ceil

LevelView = Class {}

function LevelView.getSize()
	return 26, 20
end

function LevelView:init(level_idx)
	assert(level_idx ~= nil, 'level_idx is required')

	self.font = love.graphics.newImageFont('gfx/BigLettersFont.png', ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~', -4)
	self.text = string.format('%02d', level_idx)
end

function LevelView:draw(x, y)
	local w, h = LevelView.getSize()

	love.graphics.setColor(0.0, 0.0, 0.0, 0.6)
	love.graphics.rectangle('fill', x, y, w, h)

	local dy = math_ceil((h - self.font:getHeight()) / 2) + 1
	local dx = math_ceil((w - self.font:getWidth(self.text)) / 2) + 1

	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
	love.graphics.setFont(self.font)
	love.graphics.print(self.text, x + dx, y + dy)
end
