local Background = {}
Background.__index = Background

TileSize = {
	['WIDTH'] = 32,
	['HEIGHT'] = 32,
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
			love.graphics.draw(border, borderQuads['U'], x * TileSize.WIDTH, 0)
			local y = (Map.HEIGHT + 1) * TileSize.HEIGHT
			love.graphics.draw(border, borderQuads['D'], x * TileSize.WIDTH, y)
		end	

		for y = 1, Map.HEIGHT do
			love.graphics.draw(border, borderQuads['L'], 0, y * TileSize.HEIGHT)
			local x = (Map.WIDTH + 1) * TileSize.WIDTH
			love.graphics.draw(border, borderQuads['R'], x, y * TileSize.HEIGHT)
		end

		love.graphics.draw(border, borderQuads['UL'], 0, 0)
		love.graphics.draw(border, borderQuads['UR'], (Map.WIDTH + 1) * TileSize.WIDTH, 0)
		love.graphics.draw(border, borderQuads['DL'], 0, (Map.HEIGHT + 1) * TileSize.HEIGHT)
		love.graphics.draw(border, borderQuads['DR'], (Map.WIDTH + 1) * TileSize.WIDTH, (Map.HEIGHT + 1) * TileSize.HEIGHT)
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

