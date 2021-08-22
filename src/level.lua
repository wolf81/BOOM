Level = Object:extend()

local TileSize = {
	['WIDTH'] = 32,
	['HEIGHT'] = 32,
}

local function getLevelData(index)
	local contents, _ = love.filesystem.read('dat/levels.json')
	local json, _ = json.decode(contents)

	for _, levelsData in pairs(json) do
		return levelsData[index]
	end

	return nil
end

function Level:new(index)
	print('load level' .. index)

	self._index = index

	local levelData = getLevelData(index)
	self._time = levelData['Time']
	self._borderId = levelData['BorderID']
	self._fixedBlockId = levelData['FixedBlockID']
	self._breakableBlockId = levelData['BreakableBlockID']
	self._bgPatternID = levelData['BGPatternID']
	
	local gridDescString = levelData['GridDescString']
	self._map = Map(gridDescString)

	for k, v in pairs(self) do
		print(k, v)
	end
end

function Level:update(dt)
	-- body
end

function Level:draw()
	local sw, sh = love.graphics.getDimensions()
	local lw, lh = (Map.WIDTH + 2) * TileSize.WIDTH, (Map.HEIGHT + 2) * TileSize.HEIGHT
	local ox, oy = (sw - lw) / 2, (sh - lh) / 2

	local bg = backgroundPatterns[tostring(self._bgPatternID)]	

	for y = 1, Map.HEIGHT do
		for x = 1, Map.WIDTH do
			love.graphics.draw(bg, ox + x * TileSize.WIDTH, oy + y * TileSize.HEIGHT)
		end
	end

	local border = borders[tostring(self._borderId)]
	
	for x = 1, Map.WIDTH do
		love.graphics.draw(border, borderQuads['U'], ox + x * TileSize.WIDTH, oy)
		local y = oy + (Map.HEIGHT + 1) * TileSize.HEIGHT
		love.graphics.draw(border, borderQuads['D'], ox + x * TileSize.WIDTH, y)
	end	

	for y = 1, Map.HEIGHT do
		love.graphics.draw(border, borderQuads['L'], ox, oy + y * TileSize.HEIGHT)
		local x = ox + (Map.WIDTH + 1) * TileSize.WIDTH
		love.graphics.draw(border, borderQuads['R'], x, oy + y * TileSize.HEIGHT)	
	end

	love.graphics.draw(border, borderQuads['UL'], ox, oy)
	love.graphics.draw(border, borderQuads['UR'], ox + (Map.WIDTH + 1) * TileSize.WIDTH, oy)
	love.graphics.draw(border, borderQuads['DL'], ox, oy + (Map.HEIGHT + 1) * TileSize.HEIGHT)
	love.graphics.draw(border, borderQuads['DR'], ox + (Map.WIDTH + 1) * TileSize.WIDTH, oy + (Map.HEIGHT + 1) * TileSize.HEIGHT)

end