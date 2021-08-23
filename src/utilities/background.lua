local Background = {}
Background.__index = Background

local BorderQuads = {
    ['L'] = love.graphics.newQuad(0, 0, 32, 32, 256, 32),
    ['R'] = love.graphics.newQuad(32, 0, 32, 32, 256, 32),
    ['U'] = love.graphics.newQuad(64, 0, 32, 32, 256, 32),
    ['D'] = love.graphics.newQuad(96, 0, 32, 32, 256, 32),
    ['DL'] = love.graphics.newQuad(128, 0, 32, 32, 256, 32),
    ['DR'] = love.graphics.newQuad(160, 0, 32, 32, 256, 32),
    ['UR'] = love.graphics.newQuad(192, 0, 32, 32, 256, 32),
    ['UL'] = love.graphics.newQuad(224, 0, 32, 32, 256, 32),
}

local function newBackgroundCanvas(background, border)
	local lw, lh = (Map.WIDTH + 2) * TileSize.x, (Map.HEIGHT + 2) * TileSize.y
	local canvas = love.graphics.newCanvas(lw, lh)

	love.graphics.setCanvas(canvas)

	do
		local sw, sh = love.graphics.getDimensions()
		local lw, lh = (Map.WIDTH + 2) * TileSize.x, (Map.HEIGHT + 2) * TileSize.y

		for y = 1, Map.HEIGHT do
			for x = 1, Map.WIDTH do
				love.graphics.draw(background, x * TileSize.x, y * TileSize.y)
			end
		end

		for x = 1, Map.WIDTH do
			love.graphics.draw(border, BorderQuads['U'], x * TileSize.x, 0)
			local y = (Map.HEIGHT + 1) * TileSize.y
			love.graphics.draw(border, BorderQuads['D'], x * TileSize.x, y)
		end	

		for y = 1, Map.HEIGHT do
			love.graphics.draw(border, BorderQuads['L'], 0, y * TileSize.y)
			local x = (Map.WIDTH + 1) * TileSize.x
			love.graphics.draw(border, BorderQuads['R'], x, y * TileSize.y)
		end

		love.graphics.draw(border, BorderQuads['UL'], 0, 0)
		love.graphics.draw(border, BorderQuads['UR'], (Map.WIDTH + 1) * TileSize.x, 0)
		love.graphics.draw(border, BorderQuads['DL'], 0, (Map.HEIGHT + 1) * TileSize.y)
		love.graphics.draw(border, BorderQuads['DR'], (Map.WIDTH + 1) * TileSize.x, (Map.HEIGHT + 1) * TileSize.y)
	end

	love.graphics.setCanvas()

	return canvas
end

function Background:new(offset, backgroundPatternId, borderId)
	self._backgroundPatternId = backgroundPatternId
	self._borderId = borderId
	self._offset = offset

	local backgroundPattern = backgroundPatterns[tostring(self._backgroundPatternId)]
	local border = borders[tostring(self._borderId)]
	self._canvas = newBackgroundCanvas(backgroundPattern, border)

	return setmetatable({}, Background)
end

function Background:draw()
	love.graphics.draw(self._canvas, self._offset.x, self._offset.y)
end

return setmetatable(Background, {
	__call = Background.new
})

