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
	print('load level ' .. index)

	self._index = index
	self._entities = {}

	local levelData = getLevelData(index)
	self._time = levelData['Time']
	
	local fixedBlockId = 'fblock' .. levelData['FixedBlockID']
	local breakableBlockId = 'bblock' .. levelData['BreakableBlockID']
		
	local gridDescString = levelData['GridDescString']
	self._map = Map(gridDescString)

	local sw, sh = love.graphics.getDimensions()
	local lw, lh = (Map.WIDTH + 2) * TileSize.x, (Map.HEIGHT + 2) * TileSize.y
	self._offset = vector((sw - lw) / 2, (sh - lh) / 2)

	-- create background canvas
	local backgroundPatternId = levelData['BGPatternID']
	local borderId = levelData['BorderID']
	self._background = Background(self._offset, backgroundPatternId, borderId)

	for _, block in ipairs(self._map:fblocks()) do
		local entity = EntityFactory:create(fixedBlockId, block.pos)
		self._entities[#self._entities + 1] = entity
	end

	for _, block in ipairs(self._map:bblocks()) do
		local entity = EntityFactory:create(breakableBlockId, block.pos)
		self._entities[#self._entities + 1] = entity
	end

	for _, monster in ipairs(self._map:monsters()) do
		local entity = EntityFactory:create(monster.id, monster.pos)
		self._entities[#self._entities + 1] = entity
	end

	for _, player in ipairs(self._map:players()) do
		local entity = EntityFactory:create(player.id, player.pos)
		self._entities[#self._entities + 1] = entity
	end

	for _, bonus in ipairs(self._map:bonuses()) do
		local entity = EntityFactory:create(bonus.id, bonus.pos)
		self._entities[#self._entities + 1] = entity
	end
end

function Level:update(dt)
	for _, entity in ipairs(self._entities) do
		entity:update(dt)
	end
end

function Level:draw()
	self._background:draw()

	for _, entity in ipairs(self._entities) do
		entity:draw(self._offset)
	end
end