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