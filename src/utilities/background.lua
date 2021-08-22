local Background = {}
Background.__index = Background

TileSize = {
	['WIDTH'] = 32,
	['HEIGHT'] = 32,
}

local BorderQuads = {
    ['L'] = love.graphics.newQuad(0, 0, 32, 32, 256, 32),
    ['R'] = love.graphics.newQuad(32, 0, 32, 32, 256, 32),
    ['U'] = love.graphics.newQuad(64, 0, 32, 32, 256, 32),
    ['D'] = love.graphics.newQuad(96, 0, 32, 32, 256, 32),
    ['DL'] = love.graphics.newQuad(128, 0, 32, 32, 256, 32),
    ['DR'] = love.graphics.newQuad(160, 0, 32, 32, 256, 32),
    ['UR'] = love.graphics.newQuad(196, 0, 32, 32, 256, 32),
    ['UL'] = love.graphics.newQuad(228, 0, 32, 32, 256, 32),
}

local function newBackgroundCanvas(background, border)
	local lw, lh = (Map.WIDTH + 2) * TileSize.WIDTH, (Map.HEIGHT + 2) * TileSize.HEIGHT
	local canvas = love.graphics.newCanvas(lw, lh)

	love.graphics.setCanvas(canvas)

	do
		local sw, sh = love.graphics.getDimensions()
		local lw, lh = (Map.WIDTH + 2) * TileSize.WIDTH, (Map.HEIGHT + 2) * TileSize.HEIGHT

		for y = 1, Map.HEIGHT do
			for x = 1, Map.WIDTH do
				love.graphics.draw(background, x * TileSize.WIDTH, y * TileSize.HEIGHT)
			end
		end

		for x = 1, Map.WIDTH do
			love.graphics.draw(border, BorderQuads['U'], x * TileSize.WIDTH, 0)
			local y = (Map.HEIGHT + 1) * TileSize.HEIGHT
			love.graphics.draw(border, BorderQuads['D'], x * TileSize.WIDTH, y)
		end	

		for y = 1, Map.HEIGHT do
			love.graphics.draw(border, BorderQuads['L'], 0, y * TileSize.HEIGHT)
			local x = (Map.WIDTH + 1) * TileSize.WIDTH
			love.graphics.draw(border, BorderQuads['R'], x, y * TileSize.HEIGHT)
		end

		love.graphics.draw(border, BorderQuads['UL'], 0, 0)
		love.graphics.draw(border, BorderQuads['UR'], (Map.WIDTH + 1) * TileSize.WIDTH, 0)
		love.graphics.draw(border, BorderQuads['DL'], 0, (Map.HEIGHT + 1) * TileSize.HEIGHT)
		love.graphics.draw(border, BorderQuads['DR'], (Map.WIDTH + 1) * TileSize.WIDTH, (Map.HEIGHT + 1) * TileSize.HEIGHT)
	end

	love.graphics.setCanvas()

	return canvas
end

function Background:new(x, y, backgroundPatternId, borderId)
	self._backgroundPatternId = backgroundPatternId
	self._borderId = borderId
	self._x = x
	self._y = y

	local backgroundPattern = backgroundPatterns[tostring(self._backgroundPatternId)]
	local border = borders[tostring(self._borderId)]
	self._canvas = newBackgroundCanvas(backgroundPattern, border)

	return setmetatable({}, Background)
end

function Background:draw()
	love.graphics.draw(self._canvas, self._x, self._y)
end

return setmetatable(Background, {
	__call = Background.new
})

