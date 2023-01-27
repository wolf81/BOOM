--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Game = Class { __includes = SceneBase }

local function proceedNextLevel(self)
	self.accept_input = false
	local level = LevelLoader.load(self.level.index + 1)
	if level then
		Transition.crossfade(self, Game, level)
	else
		Transition.crossfade(self, Loading, 1)
	end
end

function Game:init()
	SceneBase.init(self)
end

function Game:enter(previous, level)
	self.level = level
end

function Game:onFinishTransition()
	self.accept_input = true
end

function Game:update(dt)
	self.level:update(dt)
end

function Game:draw()
	self.level:draw()
end

function Game:keyreleased(key, code)
	if not self.accept_input then return end

    if key == 'return' then
    	proceedNextLevel(self)
    end
end
