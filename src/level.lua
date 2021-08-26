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
	self._players = {}
	self._monsters = {}
	self._blocks = {}
	self._bombs = {}
	self._coins = {}
	self._explosions = {}

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
		elseif entityInfo.id == '3' then
			local coin = EntityFactory:create(self, entityInfo.id, pos)
			self._coins[tostring(coin:gridPosition())] = coin
		elseif entityInfo.id == 'X' or entityInfo.id == 'Y' then
			self._players[#self._players + 1] = EntityFactory:create(self, entityInfo.id, pos)			
		else
			self._monsters[#self._monsters + 1] = EntityFactory:create(self, entityInfo.id, pos)
		end
	end
end

function Level:update(dt)
	for id, bomb in pairs(self._bombs) do
		bomb:update(dt)

		if bomb:isRemoved() then
			local gridPos = bomb:gridPosition()
			local size = bomb:size() + 2
			self:addExplosion(gridPos, Direction.NONE, size)

			self._bombs[id] = nil
		end
	end

	for id, coin in pairs(self._coins) do
		coin:update(dt)

		if coin:isRemoved() then
			self._coins[id] = nil
		end 
	end

	for idx, monster in lume.ripairs(self._monsters) do
		monster:update(dt)

		if monster:isRemoved() then
			table.remove(self._monsters, idx)
		end
	end

	for _, player in ipairs(self._players) do
		player:update(dt)

		for _, coin in pairs(self._coins) do
			if player:frame():intersects(coin:frame()) then
				coin:destroy()
			end
		end		
	end

	for id, block in pairs(self._blocks) do
		block:update(dt)

		if block:isRemoved() then
			self._blocks[id] = nil
		end
	end

	for idx, explosion in lume.ripairs(self._explosions) do
		explosion:update(dt)

		if explosion:isRemoved() then
			table.remove(self._explosions, idx)
		end
	end
end

function Level:draw()
	love.graphics.push()
	love.graphics.translate(self._offset.x, self._offset.y)

	self._background:draw()

	for _, bomb in pairs(self._bombs) do
		bomb:draw()
	end

	for _, coin in pairs(self._coins) do
		coin:draw()
	end

	for _, explosion in ipairs(self._explosions) do
		explosion:draw()
	end

	for _, monster in ipairs(self._monsters) do
		monster:draw()
	end

	for _, player in ipairs(self._players) do
		player:draw()
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
	bomb:fuse()
	self._bombs[tostring(bomb:gridPosition())] = bomb
end

function Level:addExplosion(gridPosition, direction, size, destroyAdjacentWalls)
	if gridPosition.x < 1 or gridPosition.x > Map.WIDTH then return end
	if gridPosition.y < 1 or gridPosition.y > Map.HEIGHT then return end

	local block = self._blocks[tostring(gridPosition)]
	if block ~= nil then
		if block:isBreakable() and destroyAdjacentWalls then 
			size = 1
			block:destroy() 
		else return end
	end

	local bomb = self._bombs[tostring(gridPosition)]
	if bomb ~= nil then
		bomb:destroy()
	end

	local explosion = EntityFactory:create(self, 'explosion', toPosition(gridPosition))
	local orientation = nil

	for idx, monster in ipairs(self._monsters) do
		if monster:frame():intersects(explosion:frame()) then
			monster:destroy()
		end
	end

	if direction == Direction.LEFT or direction == Direction.RIGHT then
		orientation = Orientation.HORIZONTAL
	elseif direction == Direction.UP or direction == Direction.DOWN then
		orientation = Orientation.VERTICAL		
	end

	explosion:explode(orientation)
	self._explosions[#self._explosions + 1] = explosion

	size = size - 1
	if size == 0 then return end

	if direction == Direction.NONE then		
		self:addExplosion(gridPosition + vector(-1, 0), Direction.LEFT, size, true)
		self:addExplosion(gridPosition + vector(1, 0), Direction.RIGHT, size, true)
		self:addExplosion(gridPosition + vector(0, 1), Direction.UP, size, true)
		self:addExplosion(gridPosition + vector(0, -1), Direction.DOWN, size, true)
	elseif direction == Direction.LEFT then
		self:addExplosion(gridPosition + vector(-1, 0), Direction.LEFT, size)
	elseif direction == Direction.RIGHT then
		self:addExplosion(gridPosition + vector(1, 0), Direction.RIGHT, size)
	elseif direction == Direction.UP then
		self:addExplosion(gridPosition + vector(0, 1), Direction.UP, size)
	elseif direction == Direction.DOWN then
		self:addExplosion(gridPosition + vector(0, -1), Direction.DOWN, size)
	end
end