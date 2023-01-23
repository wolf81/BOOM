Transition = {}

local FADE_DURATION = 0.5

local fade = { 
	alpha = 1.0,
	from_scene = nil,
	to_scene = nil,
	to_args = nil, 
}

local function startTransition(imageData)
	-- create an image from original scene
	local image = love.graphics.newImage(imageData)

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
		-- replace drawing function in next scene with the original drawing function
		love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
		fade.alpha = 1.0
	end)

	-- restore original draw function when fade is completed
	Timer.after(FADE_DURATION, function() 
		fade.to_scene.draw = to_scene_draw
	end)
	
	-- start switch to next scene
	Gamestate.switch(fade.to_scene, unpack(fade.to_args))
end

-- FIXME: currently if the crossfade function is called in quick succession, property values in fade table
-- get overwritten, causing weird bugs - either create a stack or a class that is instantiated for every 
-- transition
Transition.crossfade = function(scene1, scene2, ...)
	fade.from_scene = scene1
	fade.to_scene = scene2
	fade.to_args = {...}

	-- capture a screenshot of the current scene, callback is invoked on image captured
	love.graphics.captureScreenshot(startTransition)
end
