--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor, math_ceil, string_format = math.floor, math.ceil, string.format

TimeView = Class {}

function TimeView:init()
	self.time = 0
	self.time_color = { 1.0, 1.0, 1.0, 1.0 }
	self.time_font = love.graphics.newImageFont('gfx/BigLettersFont.png', ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~', -4)
	-- self.time_font = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 14)
	self.minutes = '00'
	self.seconds = '00'
end

function TimeView:updateTime(time)
	if self.time == time then return end

	self.time = time

	local minutes = self.time / 60
	local seconds = math_ceil(time % 60)
	if seconds == 60 then
		seconds = 0
		minutes = minutes + 1
	end
	self.minutes = string_format('%02d', minutes)
	self.seconds = string_format('%02d', seconds)

	if self.time <= 30 then
		self.time_color = { 1.0, 0.0, 0.0, 1.0 }
	end
end

function TimeView:draw(x, y)
	love.graphics.setFont(self.time_font)
	love.graphics.setColor(self.time_color)
	love.graphics.print(self.minutes, x, y)
	love.graphics.print(':', x + 25, y)
	love.graphics.print(self.seconds, x + 32, y)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end
