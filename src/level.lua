Level = Object:extend()

local tileSize = vector(32, 32)

local function getFixedBlockQuad(blockId, tex)
	local tex = blocks['fixed']
	local qy = blockId * TileSize.y
	return love.graphics.newQuad(0, qy, TileSize.x, TileSize.x, tex)
end 

local function getBreakableBlockQuad(blockId, tex)
	local tex = blocks['breakable']
	local qx = blockId * TileSize.x
	return love.graphics.newQuad(qx, 0, TileSize.x, TileSize.x, tex)
end

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
	
	local fixedBlockId = levelData['FixedBlockID']
	self._fixedBlockQuad = getFixedBlockQuad(fixedBlockId, blocks['fixed'])

	local breakableBlockId = levelData['BreakableBlockID']
	self._breakableBlockQuad = getBreakableBlockQuad(breakableBlockId, blocks['breakable'])
		
	local gridDescString = levelData['GridDescString']
	self._map = Map(gridDescString)

	for k, v in pairs(self) do
		print(k, v)
	end

	local sw, sh = love.graphics.getDimensions()
	local lw, lh = (Map.WIDTH + 2) * TileSize.x, (Map.HEIGHT + 2) * TileSize.y
	self._offset = vector((sw - lw) / 2, (sh - lh) / 2)

	-- create background canvas
	local backgroundPatternId = levelData['BGPatternID']
	local borderId = levelData['BorderID']
	self._background = Background(self._offset, backgroundPatternId, borderId)
end

function Level:update(dt)
	-- body
end

function Level:draw()
	self._background:draw()

	for _, block in ipairs(self._map:blocks()) do
		local pos = block:position():permul(tileSize) + self._offset

		if block:isBreakable() then
			local tex = blocks['breakable']
			local quad = self._breakableBlockQuad
			love.graphics.draw(tex, quad, pos.x, pos.y)
		else
			local tex = blocks['fixed']
			local quad = self._fixedBlockQuad
			love.graphics.draw(tex, quad, pos.x, pos.y)
		end
	end
end