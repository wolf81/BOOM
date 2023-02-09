--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor, math_min, math_max = math.floor, math.min, math.max

Overlay = {}

local SPEED = WINDOW_H / 2 / 0.5

-- pending overlays
local queue = {}

-- active overlay
local current = nil

-- configure an overlay
local function configure(image_path, sound_path)
	local image = love.graphics.newImage(image_path)
	local image_w, image_h = image:getDimensions()

	return {
		image = image,
		sound = love.audio.newSource(sound_path, 'static'),
		x = math_floor((WINDOW_W - HUD_W - image_w) / 2),
		y = -image_h,
		mid_y = math_floor((WINDOW_H - image_h) / 2),
		delay = 1.0,
		state = 'showing',
	}
end

function Overlay.show(image_path, sound_path)
	assert(image_path ~= nil and type(image_path) == 'string', 'image_path is required')
	assert(sound_path ~= nil and type(sound_path) == 'string', 'sound_path is required')
	table.insert(queue, configure(image_path, sound_path))
end

function Overlay.update(dt)
	if not current then
		-- if pending items in queue, make first item the current item
		if #queue > 0 then 
			current = table.remove(queue, 1)
			love.audio.play(current.sound)
		else return end
	end

	if current.state == 'showing' then -- show in 0.5 seconds
		current.y = math_min(current.y + SPEED * dt, current.mid_y)
		if current.y == current.mid_y then current.state = 'pausing' end
	elseif current.state == 'pausing' then -- pause for 1.0 seconds
		current.delay = math_max(current.delay - dt, 0)	
		if current.delay == 0 then current.state = 'hiding' end
	elseif current.state == 'hiding' then -- hide in 0.5 seconds
		current.y = math_min(current.y + SPEED * dt, WINDOW_H)
		if current.y == WINDOW_H then current = nil end
	end
end

function Overlay.draw()
	if not current then return end

	love.graphics.draw(current.image, current.x, current.y)
end
