Level = Object:extend()

local function getLevelData(index)
	local contents, _ = love.filesystem.read('dat/levels.json')
	local json, _ = json.decode(contents)

	for _, levelsData in pairs(json) do
		return levelsData[index]
	end

	return nil
end

function Level:getDimensions()
	return (Map.WIDTH + 2) * TileSize.w, (Map.HEIGHT + 2) * TileSize.h
end

local bonusProbabilities = nil

local function configureBonusProbabilities()
	bonusProbabilities = Probability()

	local bonuses = EntityFactory:getEntitiesOfType(Bonus)
    for _, bonus in ipairs(bonuses) do
    	bonusProbabilities:add(bonus._data.id, bonus._data.spawnChance)       
    end
end

function Level:players()
	return self._players
end

function Level:time()
	return math.ceil(self._time)
end

function Level:new(index)
	print('load level ' .. index)

	if bonusProbabilities == nil then
		configureBonusProbabilities()
	end

	local levelData = getLevelData(index)
	
	self._index = index
	self._time = levelData['Time'] or 0
	self._explosions = {}
	self._bombs = {}
	self._blocks = {}
	self._players = {}
	self._monsters = {}
	self._coins = {}
	self._bonuses = {}

	local fixedBlockId = 'fblock' .. levelData['FixedBlockID']
	local breakableBlockId = 'bblock' .. levelData['BreakableBlockID']

	local gridDescString = levelData['GridDescString']
	local map = Map(gridDescString)

	-- create background canvas
	local backgroundPatternId = levelData['BGPatternID']
	local borderId = levelData['BorderID']

	print('fixedBlockId: ' .. fixedBlockId)
	print('BreakableBlockID: ' .. breakableBlockId)
	print('backgroundPatternId: ' .. backgroundPatternId)
	print('borderId: ' .. borderId)

	self._background = Background(backgroundPatternId, borderId)

	for _, entityInfo in ipairs(map:entityInfos()) do
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
			local player = EntityFactory:create(self, entityInfo.id, pos)
			self._players[#self._players + 1] = player
		else
			local monster = EntityFactory:create(self, entityInfo.id, pos)
			self._monsters[#self._monsters + 1] = monster
			monster:setControl(CpuControl(self, monster))
		end
	end
end

function Level:players()
	return self._players
end

function Level:update(dt)
	self._time = math.max(self._time - dt, 0)

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

	for id, bonus in pairs(self._bonuses) do
		bonus:update(dt)

		if bonus:isRemoved() then
			self._bonuses[id] = nil
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

		local playerFrame = player:frame()

		for _, coin in pairs(self._coins) do
			if playerFrame:intersects(coin:frame()) then
				coin:destroy()
			end
		end

		for _, bonus in pairs(self._bonuses) do
			if playerFrame:intersects(bonus:frame()) then
				player:applyBonus(bonus)
				bonus:destroy()
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
	self._background:draw()

	for _, bomb in pairs(self._bombs) do
		bomb:draw()
	end

	for _, coin in pairs(self._coins) do
		coin:draw()
	end

	for _, bonus in pairs(self._bonuses) do
		bonus:draw()
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
end

function Level:trySpawnBonus(gridPosition)
	local bonusId = bonusProbabilities:random()

	if bonusId == 'b_dummy' then return end
	
	local bonus = EntityFactory:create(self, bonusId, toPosition(gridPosition))
	self._bonuses[tostring(gridPosition)] = bonus
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
	local gridPosition = toGridPosition(position)
	if self._bombs[tostring(gridPosition)] ~= nil then return end
	
	local bomb = EntityFactory:create(self, 'bomb', toPosition(gridPosition))
	bomb:fuse()
	self._bombs[tostring(bomb:gridPosition())] = bomb
end

function Level:addExplosion(gridPosition, direction, size, destroyAdjacentWalls)
	if gridPosition.x < 1 or gridPosition.x > Map.WIDTH then return end
	if gridPosition.y < 1 or gridPosition.y > Map.HEIGHT then return end

	local block = self._blocks[tostring(gridPosition)]
	if block ~= nil then
		if not block:isBreakable() then 
			return
		elseif destroyAdjacentWalls then 
			size = 1
			block:destroy()
		else return end
	end

	local bomb = self._bombs[tostring(gridPosition)]
	if bomb ~= nil then
		bomb:destroy()
	end

	local explosion = EntityFactory:create(self, 'explosion', toPosition(gridPosition))

	for idx, monster in ipairs(self._monsters) do
		if monster:frame():intersects(explosion:frame()) then
			monster:destroy()
		end
	end

	local orientation = nil
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