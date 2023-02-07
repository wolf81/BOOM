--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local string_format = string.format

ScoreView = Class {}

local FONT_SIZE = 16

local function updateScoreViewTexture(self)
	local canvas = love.graphics.newCanvas(HUD_W, 50)

	canvas:renderTo(function() 
		love.graphics.setCanvas(canvas)

		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

		love.graphics.setFont(self.score_title_font)
		love.graphics.print('score')

		love.graphics.setFont(self.score_value_font)
		love.graphics.print(string_format('%06d', self.score), 0, 20)
	end)

	return canvas
end

function ScoreView:init()
	self.score_title_font = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', FONT_SIZE)
	self.score_value_font = love.graphics.newFont('fnt/pf_tempesta_seven_condensed.ttf', FONT_SIZE)

	self.score = 0
	self.canvas = updateScoreViewTexture(self)	
end

function ScoreView:updateScore(score)
	if score == self.score then return end

	self.score = score
	self.canvas = updateScoreViewTexture(self)
end

function ScoreView:draw(x, y)
	love.graphics.draw(self.canvas, x, y)
end