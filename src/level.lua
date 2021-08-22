Level = Object:extend()

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
	self._fixedBlockId = levelData['FixedBlockID']
	self._breakableBlockId = levelData['BreakableBlockID']
		
	local gridDescString = levelData['GridDescString']
	self._map = Map(gridDescString)

	for k, v in pairs(self) do
		print(k, v)
	end

	local sw, sh = love.graphics.getDimensions()
	local lw, lh = (Map.WIDTH + 2) * TileSize.WIDTH, (Map.HEIGHT + 2) * TileSize.HEIGHT
	local ox, oy = (sw - lw) / 2, (sh - lh) / 2

	-- create background canvas
	local backgroundPatternId = levelData['BGPatternID']
	local borderId = levelData['BorderID']
	self._background = Background(ox, oy, backgroundPatternId, borderId)
end

function Level:update(dt)
	-- body
end

function Level:draw()
	self._background:draw()
end