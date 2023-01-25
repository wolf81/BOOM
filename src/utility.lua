function GenerateQuads(image, width, height)
	local quads = {}

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
        	quads[#quads + 1] = love.graphics.newQuad(x, y, width, height, image:getDimensions())
        end
    end

    return quads
end
