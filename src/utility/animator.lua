--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor = math.floor

Animator = {}

local cache = {}

-- register animations for entity type
Animator.register = function(key, image, quads)
	cache[key] = { image, quads }
end

Animator.draw = function(key, animation, x, y)
	-- retrieve texture & quads for the animation
	local image, quads = unpack(cache[key])
	love.graphics.draw(image, quads[animation:getCurrentFrame()], math_floor(x), math_floor(y))
end
