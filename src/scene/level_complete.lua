--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor = math.floor

LevelComplete = Class { __includes = SceneBase }

local function generateBackground()
	local canvas = love.graphics.newCanvas(WINDOW_W - HUD_W, WINDOW_H)

	canvas:renderTo(function()
		love.graphics.setCanvas(canvas)
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
	end)

	return canvas
end

local function proceedNextLevel(self)
	local level, background = LevelLoader.load(self.level.index + 1)
	print('=>', self.level.index)
	if level then
		Transition.crossfade(self, Game, level, background)
	else
		Transition.crossfade(self, Loading, 1)
	end
end

function LevelComplete:init()
	SceneBase.init(self)

	self.font = love.graphics.newImageFont('gfx/BigLettersFontCondensed.png', ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~', 1)
	self.background = generateBackground()
end

function LevelComplete:enter(previous, level)
	print('ENTER LEVEL COMPLETE')
	self.level = level
	self.hud = Hud(self.level)

	self.text = 'TIME BONUS!'

	Timer.after(3.0, function() proceedNextLevel(self) end)
end

function LevelComplete:update(dt)
	self.hud:update(dt)
end

function LevelComplete:draw()
	love.graphics.push()
	love.graphics.translate(HUD_W, 0)
	love.graphics.draw(self.background)


	love.graphics.setFont(self.font)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
	local w = self.font:getWidth(self.text)
	local h = self.font:getHeight()
	love.graphics.print('TIME BONUS!', math_floor((WINDOW_W - HUD_W - w) / 2), math_floor((WINDOW_H - h) / 2))

	love.graphics.pop()

	self.hud:draw()
end
