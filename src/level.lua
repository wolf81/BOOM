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
	self._blocks = {}
	self._bombs = {}

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

	print('fixedBlockId: ' .. fixedBlockId)
	print('BreakableBlockID: ' .. breakableBlockId)
	print('backgroundPatternId: ' .. backgroundPatternId)
	print('borderId: ' .. borderId)

	self._background = Background(backgroundPatternId, borderId)

	for _, entityInfo in ipairs(self._map:entityInfos()) do
		local entity = nil

		local pos = entityInfo.pos:permul(TileSize)

		if entityInfo.id == '1' then
			local block = EntityFactory:create(self, fixedBlockId, pos)
			self._blocks[tostring(block:gridPosition())] = block
		elseif entityInfo.id == '2' then
			local block = EntityFactory:create(self, breakableBlockId, pos)
			self._blocks[tostring(block:gridPosition())] = block
		else
			self._entities[#self._entities + 1] = EntityFactory:create(self, entityInfo.id, pos)
		end
	end
end

function Level:update(dt)
	for _, bomb in pairs(self._bombs) do
		bomb:update(dt)
	end

	for _, entity in ipairs(self._entities) do
		entity:update(dt)
	end

	for _, block in pairs(self._blocks) do
		block:update(dt)
	end
end

function Level:draw()
	love.graphics.push()
	love.graphics.translate(self._offset.x, self._offset.y)

	self._background:draw()

	for _, bomb in pairs(self._bombs) do
		bomb:draw()
	end

	for _, entity in ipairs(self._entities) do
		entity:draw()
	end

	for _, block in pairs(self._blocks) do
		block:draw()
	end

	love.graphics.pop()
end

function Level:isBlocked(gridPosition)
	if gridPosition.x < 1 or gridPosition.y < 1 then return true end
	if gridPosition.x > Map.WIDTH or gridPosition.y > Map.HEIGHT then return true end

	if self._blocks[tostring(gridPosition)] ~= nil then
		return true
	end

	return false
end

function Level:addBomb(position)
	local bomb = EntityFactory:create(self, 'bomb', toPosition(toGridPosition(position)))
	self._bombs[#self._bombs + 1] = bomb

end