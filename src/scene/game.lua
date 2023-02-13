--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Game = Class { __includes = SceneBase }

local function generateBackground()
	local canvas = love.graphics.newCanvas(WINDOW_W - HUD_W, WINDOW_H)

	canvas:renderTo(function()
		love.graphics.setCanvas(canvas)
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
	end)

	return canvas
end

local function levelComplete(self)
	if self.level then
		Transition.crossfade(self, LevelComplete, self.level)
	else
		Transition.crossfade(self, Loading, 1)
	end
end

function Game:init()
	SceneBase.init(self)

	self.background = generateBackground()
end

function Game:enter(previous, level, background)
	self.level = level
	self.background = background
	self.hud = Hud(self.level, true)
end

function Game:onFinishTransition()
	self.accept_input = true
end

function Game:update(dt)
	self.hud:update(dt)
	self.level:update(dt)
end

function Game:draw()
	love.graphics.push()
	love.graphics.translate(HUD_W, 0)
	love.graphics.draw(self.background)
	self.level:draw()
	love.graphics.pop()

	self.hud:draw()
end

function Game:keyreleased(key, code)
	if not self.accept_input then return end

    if key == 'f1' then levelComplete(self)
    elseif key == 'f2' then self.level:destroyBlocks()
    elseif key == 'f5' then
    	local obj = self.level:serialize()
    	self.level = Level.deserialize(obj)
    	self.hud.level = self.level
    end
end
