local lume_round = lume.round

-- generate a list of quads for a given image, tile width & tile height
function GenerateQuads(image, width, height)
	local quads = {}
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
        	quads[#quads + 1] = love.graphics.newQuad(x, y, width, height, image:getDimensions())
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

-- get a position adjacent to the given position, but constrained to grid positions
-- e.g. with TILE_W of 32, x-values in range 0, 32, 64, 96, ...
function GetAdjacentPosition(pos, direction)
	local to_pos = pos + (direction or Direction.NONE):permul(TILE_SIZE)
	return vector(lume_round(to_pos.x, TILE_W), lume_round(to_pos.y, TILE_H))
end

function GetKeys(tbl, filter)
	local keys = {}
	for key, _ in pairs(tbl) do
		if filter then
			if string.find(key, filter) then
				keys[#keys + 1] = key
			end
		else
			keys[#keys + 1] = key
		end
	end
	return keys
end
