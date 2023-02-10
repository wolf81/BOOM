--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Loading = Class { __includes = SceneBase }

local function loadFiles()
	local dir = love.filesystem.getRealDirectory(path)
	local fn = assert(loadfile(dir .. path))
end

function Loading:init()
	SceneBase.init(self)
end

function Loading:enter(previous, level_idx)
	self.level_idx = level_idx
	ImageCache.clear()

	-- register entities with factory, so we can quickly spawn entities
	EntityFactory.register('/dat/entity_defs.lua')

	-- preload graphics
	local paths = love.filesystem.getDirectoryItems('gfx')
	for _, path in ipairs(paths) do
		ImageCache.load('gfx/' .. path)
	end

	-- preload sounds
	local paths = love.filesystem.getDirectoryItems('sfx')
	for _, path in ipairs(paths) do
		AudioPlayer.load('sfx/' .. path)
	end
end

function Loading:onFinishTransition()
	local level, background = LevelLoader.load(self.level_idx)
	Transition.crossfade(self, Game, level, background)
end

function Loading:update(dt)
	-- body
end

function Loading:draw()
	local width, height = love.graphics.getWidth(), love.graphics.getHeight()

	love.graphics.setColor(0.0, 0.0, 0.0)
	love.graphics.rectangle('fill', 0, 0, width, height)
end
