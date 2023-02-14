--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

-- ImageFontCondenser
--
-- A script that can be used to condense a fixed width image font into variable width
-- Should be run from a LÖVE project & the identity should be configured to store the
-- result.
--
-- The image font condenser expects an image font specially formatted for LÖVE 2D, as
-- such the top left pixel should contain the spacer color. Also all letters should be
-- arranged horizontally.

local ImageFontCondenser = {}

-- utility function to get filename from a path
local function getFilename(path) return path:match( "([^/]+)$" ) end

ImageFontCondenser.condense = function(image_font_path)
	-- load image data to read pixel values & load image for copying quads
	local image_data = love.image.newImageData(image_font_path)
	local image = love.graphics.newImage(image_data)

	-- get dimensions, so we can check each pixel in the original image
	local w, h = image:getDimensions()

	-- create a canvas to draw on, this canvas will contain the condensed sprite font
	local canvas = love.graphics.newCanvas(w, h)
	local canvas_x = 0

	-- extract the first pixel to determine the spacer color
	-- see: https://love2d.org/wiki/ImageFontFormat
	local spacer_color = { image_data:getPixel(0, 0) }

	-- sprite width of current sprite
	local sprite_w = 0

	-- end position of current sprite (range: x1 .. x2)
	local x2 = 0

	-- save current blend mode, so we can restore when finished with drawing on the canvas
	local blend_mode = love.graphics.getBlendMode()

	-- set blend mode to replace, in order to replace the spacer background color on canvas
	love.graphics.setBlendMode('replace')

	-- start rendering to canvas
	canvas:renderTo(function()
		-- fill canvas with spacer color
		love.graphics.setColor(unpack(spacer_color))
		love.graphics.rectangle('fill', 0, 0, w, h)

		-- process pixels from left to right
		for x = 0, w - 1 do
			-- increase sprite width, until we see spacer color
			sprite_w = sprite_w + 1

			-- check if color is equal to spacer color - if true, we can backtrack to find first non-transparent pixel
			local r, g, b, a = image_data:getPixel(x, 1)
			if r == spacer_color[1] and g == spacer_color[2] and b == spacer_color[3] and a == spacer_color[4] then
				x2 = x - 1

				-- determine start position of letter
				local x1 = x - sprite_w + 1

				-- backtrack to first non-transparent pixel
				for pix_x = x2, x1, -1 do
					for pix_y = 0, h - 1 do
						local _, _, _, pix_a = image_data:getPixel(pix_x, pix_y)

						-- colored pixel found, extract sprite until first transparent vertical line
						if pix_a ~= 0.0 then
							-- adjust sprite width for correct character width
							sprite_w = pix_x - x1 + 1

							-- draw the letter on the canvas
							local quad = love.graphics.newQuad(x1, 0, sprite_w, h, image)
							love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
							love.graphics.draw(image, quad, canvas_x, 0)

							-- continue with next character
							goto continue
						end
					end
				end

				-- no colored pixels found, so extract white space
				do
					-- draw whitespace on the canvas
					local quad = love.graphics.newQuad(x1, 0, sprite_w, h, image)
					love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
					love.graphics.draw(image, quad, canvas_x, 0)

					-- adjust sprite width to compensate for red border
					sprite_w = sprite_w - 1
				end

				-- continue with next character
				::continue::

				-- update position on canvas, for drawing next letter
				canvas_x = canvas_x + sprite_w + 1

				-- reset sprite width
				sprite_w = 0
			end
		end
	end)

	-- restore canvas & blend mode
	love.graphics.setCanvas()
	love.graphics.setBlendMode(blend_mode)

	-- store the result in directory determined by identity configured in LÖVE
	local out_path = getFilename(image_font_path)
	canvas:newImageData(nil, 1, 0, 0, canvas_x, h):encode('png', out_path)
end

return ImageFontCondenser
