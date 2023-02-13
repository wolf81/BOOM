local SpriteFontCompacter = {}

local function getFilename(path)
	return path:match( "([^/]+)$" )
end

SpriteFontCompacter.compact = function(image_font_path)
	local image_data = love.image.newImageData(image_font_path)
	local image = love.graphics.newImage(image_data)

	local w, h = image:getDimensions()

	local canvas = love.graphics.newCanvas(w, h)
	local canvas_x = 0

	local split_color = { image_data:getPixel(0, 0) }

	local x2, sprite_w = 0, 0

	love.graphics.setBlendMode('replace')

	canvas:renderTo(function()
		love.graphics.setColor(unpack(split_color))
		love.graphics.rectangle('fill', 0, 0, w, h)

		for x = 0, w - 1 do
			sprite_w = sprite_w + 1

			local r, g, b, a = image_data:getPixel(x, 1)
			if r == split_color[1] and g == split_color[2] and b == split_color[3] and a == split_color[4] then
				x2 = x - 1
				-- from red pixel, move backwards until we find the first non-transparent pixel

				local x1 = x - sprite_w + 1

				for pix_x = x2, x1, -1 do
					for pix_y = 0, h - 1 do
						local _, _, _, pix_a = image_data:getPixel(pix_x, pix_y)

						-- colored pixel found, extract sprite until first transparent vertical line
						if pix_a ~= 0.0 then
							sprite_w = pix_x - x1 + 1
							local quad = love.graphics.newQuad(x1, 0, sprite_w, h, image)

							love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
							love.graphics.draw(image, quad, canvas_x, 0)

							-- extract the next character
							goto continue
						end
					end
				end

				-- no colored pixels found, so extract white space
				do
					local quad = love.graphics.newQuad(x1, 0, sprite_w, h, image)
					-- TODO: figure out why we need to reduce sprite_w by 1 for empty space areas
					-- in order to align all sprites nicely
					sprite_w = sprite_w - 1

					love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
					love.graphics.draw(image, quad, canvas_x, 0)
				end

				::continue::

				canvas_x = canvas_x + sprite_w + 1

				sprite_w = 0
			end
		end
	end)

	local out_path = getFilename(image_font_path)
	canvas:newImageData(nil, 1, 0, 0, canvas_x, h):encode('png', out_path)
end

return SpriteFontCompacter