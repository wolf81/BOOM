Level = Object:extend()

local function getFixedBlockQuad(blockId, tex)
	local tex = blocks['fixed']
	local qy = blockId * TileSize.WIDTH
	return love.graphics.newQuad(0, qy, TileSize.WIDTH, TileSize.WIDTH, tex)
end 

local function getBreakableBlockQuad(blockId, tex)
	local tex = blocks['breakable']
	local qx = blockId * TileSize.WIDTH
	return love.graphics.newQuad(qx, 0, TileSize.WIDTH, TileSize.WIDTH, tex)
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
	local lw, lh = (Map.WIDTH + 2) * TileSize.WIDTH, (Map.HEIGHT + 2) * TileSize.HEIGHT
	self._ox = (sw - lw) / 2
	self._oy = (sh - lh) / 2

	-- create background canvas
	local backgroundPatternId = levelData['BGPatternID']
	local borderId = levelData['BorderID']
	self._background = Background(self._ox, self._oy, backgroundPatternId, borderId)
end

function Level:update(dt)
	-- body
end

function Level:draw()
	self._background:draw()

	for _, block in ipairs(self._map:blocks()) do
		if block:isBreakable() then
			local x, y = block:position()
			local tex = blocks['breakable']
			local quad = self._breakableBlockQuad
			love.graphics.draw(tex, quad, self._ox + x * TileSize.WIDTH, self._oy + y * TileSize.HEIGHT)
		else
			local x, y = block:position()
			local tex = blocks['fixed']
			local quad = self._fixedBlockQuad
			love.graphics.draw(tex, quad, self._ox + x * TileSize.WIDTH, self._oy + y * TileSize.HEIGHT)
		end
	end
end