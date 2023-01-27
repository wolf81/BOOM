--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Loading = Class { __includes = SceneBase }

function Loading:init() 
	SceneBase.init(self)
end

function Loading:enter(previous, level_idx)
	self.level_idx = level_idx
	ImageCache.clear()
end

function Loading:onFinishTransition()	
	local level = LevelLoader.load(self.level_idx)
	Transition.crossfade(self, Game, level)
end

function Loading:update(dt)
	-- body
end

function Loading:draw()
	local width, height = love.graphics.getWidth(), love.graphics.getHeight()

	love.graphics.setColor(0.0, 0.0, 0.0)
	love.graphics.rectangle('fill', 0, 0, width, height)
end
