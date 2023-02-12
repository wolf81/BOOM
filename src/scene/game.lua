--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Game = Class { __includes = SceneBase }

local level_str = nil

local function generateBackground()
	local canvas = love.graphics.newCanvas(WINDOW_W - HUD_W, WINDOW_H)

	canvas:renderTo(function()
		love.graphics.setCanvas(canvas)
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
	end)

	return canvas
end

local function proceedNextLevel(self)
	self.accept_input = false
	local level, background = LevelLoader.load(self.level.index + 1)
	if level then
		-- level.players = {}
		-- for _, player in ipairs(self.level.players) do
		-- 	level:addEntity(player)
		-- end

		Transition.crossfade(self, Game, level, background)
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
	self.hud = Hud(self.level)
end

function Game:onFinishTransition()
	self.accept_input = true
end

function Game:update(dt)
	self.hud:update(dt)
	self.level:update(dt)
end

function Game:draw()
	self.hud:draw()

	love.graphics.push()
	love.graphics.translate(HUD_W, 0)
	love.graphics.draw(self.background)
	self.level:draw()
	love.graphics.pop()
end

function Game:keyreleased(key, code)
	if not self.accept_input then return end

    if key == 'f1' then proceedNextLevel(self)
    elseif key == 'f2' then self.level:destroyBlocks()
    elseif key == 'f5' then
    	local obj = self.level:serialize()
    	-- PrintTable(obj)
    	local t = bitser.dumps(obj.entities[4])
    	self.level = Level.deserialize(obj)

    	self.hud.level = self.level
    end
end
