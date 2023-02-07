--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor, math_ceil, string_format = math.floor, math.ceil, string.format

TimeView = Class {}

local function toTimeString(seconds)
	-- TODO: should actually create 4 strings here, so we can spread out evenly
	-- or perhaps use a monospaced font, to ensure time is always of equal size
	local minutes = seconds / 60
	local seconds = math_ceil(seconds % 60)
	if seconds == 60 then
		seconds = 0
		minutes = minutes + 1
	end
	return string_format('%02d:%02d', minutes, seconds)	
end

function TimeView:init()
	self.time = 0
	self.time_color = { 1.0, 1.0, 1.0, 1.0 }
	self.time_font = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 14)
	self.time_string = toTimeString(self.time)
end

function TimeView:updateTime(time)
	if self.time == time then return end

	self.time = time

	if self.time <= 30 then
		self.time_color = { 1.0, 0.0, 0.0, 1.0 }
	end

	self.time_string = toTimeString(self.time)
end

function TimeView:draw(x, y)
	love.graphics.setFont(self.time_font)	
	love.graphics.setColor(self.time_color)
	love.graphics.print(self.time_string, x, y)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end
