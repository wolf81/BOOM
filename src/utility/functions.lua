--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_round = lume.round

-- generate a list of quads for a given image, tile width & tile height
function GenerateQuads(image, width, height)
	local quads = {}
	local image_w, image_h = image:getDimensions()
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
        	quads[#quads + 1] = love.graphics.newQuad(x, y, width, height, image_w, image_h)
        end
    end    
    return quads
end

-- parse an animation definition, converting it to an Animation instance
function ParseAnimations(animation_defs)
	local animations = {}
	for k, v in pairs(animation_defs) do
		animations[k] = Animation(v)
	end
	return animations
end

-- given a table with 2 int values, return first value as width, second as height
-- otherwise return default tile size as defined in constants
function ParseSpriteSize(size)
	local size = size or { TILE_W, TILE_H }
	return size[1], size[2]
end

-- get a world position adjacent to the given position, the position is constrained 
-- to grid positions, e.g. with TILE_W of 32, x-values in set 0, 32, 64, 96, ...
function GetAdjacentPosition(pos, direction)
	local to_pos = pos + (direction or Direction.NONE):permul(TILE_SIZE)
	return vector(lume_round(to_pos.x, TILE_W), lume_round(to_pos.y, TILE_H))
end

-- convert a world position into a grid position based on tile size
function ToGridPosition(pos)
	return vector(lume_round(pos.x / TILE_W), lume_round(pos.y / TILE_H))
end
