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
	local lw, lh = Map.WIDTH * TileSize.WIDTH, Map.HEIGHT * TileSize.HEIGHT
	local ox, oy = (sw - lw - TileSize.WIDTH) / 2, (sh - lh - TileSize.HEIGHT) / 2

	local bg = backgroundPatterns[tostring(self._bgPatternID)]

	for y = 0, Map.HEIGHT do
		for x = 0, Map.WIDTH do
			love.graphics.draw(bg, ox + x * TileSize.WIDTH, oy + y * TileSize.HEIGHT)
		end
	end
end