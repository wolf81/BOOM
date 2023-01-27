--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local Gamestate = require 'lib.hump.gamestate'

Transition = {}

-- duration of fade animation
local FADE_DURATION = 0.5

-- a flag to check whether initial Gamestate is set
local is_initialized = false

-- a list of pending transitions
local transitions = {}

-- validate a scene by ensuring all methods from SceneBase are included
local function assertScene(scene)
	assert(scene ~= nil, 'scene should be defined')
	for k, v in pairs(SceneBase) do
		-- ensure property is defined
		assert(scene[k] ~= nil, 'scene should inherit from SceneBase')
		-- ensure property type of scene is equal to property type of SceneBase
		assert(type(scene[k]) == type(v), 'scene should inherit from SceneBase')
	end
end

-- this callback is invoked when screenshot capture is completed
local function startTransition(imageData)
	-- create an image from original scene
	local image = love.graphics.newImage(imageData)

	-- remove transition from pending transitions list
	local fade = table.remove(transitions, 1)

	-- notify next scene we are starting the transition
	fade.to_scene:onStartTransition()

	-- store drawing function for next scene in local variable
	local to_scene_draw = fade.to_scene.draw

	-- for next scene, replace drawing function with custom implementation
	fade.to_scene.draw = function()
		-- first draw next scene
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
		to_scene_draw(fade.to_scene)

		-- now draw an image of previous scene, but use alpha value for fade
		love.graphics.setColor(1.0, 1.0, 1.0, fade.alpha)
		love.graphics.draw(image)				
	end

	-- tween fade alpha value
	Timer.tween(FADE_DURATION, fade, { alpha = 0.0 }, 'in-out-quad', function()
		-- restore original draw function when fade is completed
		fade.to_scene.draw = to_scene_draw

		-- ensure colors are drawn normally on subsequent draw calls
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

		-- notify next scene the transition is completed
		fade.to_scene.onFinishTransition(fade.to_scene)
	end)
	
	-- start switch to next scene
	Gamestate.switch(fade.to_scene, unpack(fade.to_args))
end

-- the initialize function should be called to load initial scene
Transition.init = function(to, ...)
	assert(is_initialized == false, 'already initialized')

	-- create a black dummy scene for fade in animation
	local DummyScene = Class { __includes = SceneBase }
	DummyScene.draw = function()
		love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
		local window_w, window_h = love.window.getMode()
		love.graphics.rectangle('fill', 0, 0, window_w, window_h)
	end

	-- make Gamestate respond to draw() & update() calls
	Gamestate.registerEvents()

	-- initialize Gamestate with the black dummy scene
	Gamestate.switch(DummyScene)
	is_initialized = true

	-- start a cross fade animation to target scene
	Transition.crossfade(DummyScene, to, ...)
end

-- perform a crossfade transition between scenes with optional arguments
Transition.crossfade = function(from, to, ...)
	assert(is_initialized, 'Transitions not initialized, ensure init is called first')
	assertScene(from)
	assertScene(to)

	-- add transition to pending transitions list
	transitions[#transitions + 1] = {
		from_scene = from,
		to_scene = to,
		to_args = {...},
		alpha = 1.0,
	}

	-- capture a screenshot of the current scene, callback is invoked on image captured
	love.graphics.captureScreenshot(startTransition)
end
