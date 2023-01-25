function GenerateQuads(image, width, height)
	local quads = {}

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
        	quads[#quads + 1] = love.graphics.newQuad(x, y, width, height, image:getDimensions())
        end
    end

    return quads
end

function ParseAnimations(animation_defs)
	local animations = {}
	for k, v in pairs(animation_defs) do
		animations[k] = Animation(v)
	end
	return animations
end

function ParseSpriteSize(size)
	if size then return size[1], size[2] end
	return TILE_W, TILE_H
end
