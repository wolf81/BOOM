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
	print('backgroundPatternId: ' .. backgroundPatternId)
	local borderId = levelData['BorderID']
	print('borderId: ' .. borderId)
	self._background = Background(self._offset, backgroundPatternId, borderId)

	for _, entityInfo in ipairs(self._map:entityInfos()) do
		local entity = nil

		if entityInfo.id == '1' then			
			entity = EntityFactory:create(fixedBlockId, entityInfo.pos)
		elseif entityInfo.id == '2' then
			entity = EntityFactory:create(breakableBlockId, entityInfo.pos)
		else
			entity = EntityFactory:create(entityInfo.id, entityInfo.pos)
		end

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