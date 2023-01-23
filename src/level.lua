local json = require 'lib.json.json'

Level = Class {}

local function generateBackground(bg_pattern_id, border_id)
	local canvas = love.graphics.newCanvas(WINDOW_W, WINDOW_H)
	love.graphics.setCanvas(canvas)

	love.graphics.clear(0, 0, 0, 0)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)

	-- draw background
	local bg_tile = love.graphics.newImage('gfx/BGPattern ' .. string.format('%02d', bg_pattern_id + 1) .. '.png')

	for y = 1, MAP_H do
		for x = 1, MAP_W do
			love.graphics.draw(bg_tile, x * TILE_W, y * TILE_W)
		end
	end

	-- draw borders
	local border_tiles = love.graphics.newImage('gfx/Border ' .. string.format('%02d', border_id + 1) .. '.png')

	-- top 
	local quad = love.graphics.newQuad(TILE_W * 0, 0, TILE_W, TILE_H, border_tiles)
	for y = 1, MAP_H do
		love.graphics.draw(border_tiles, quad, 0, y * TILE_H)
	end
	
	-- bottom
	quad = love.graphics.newQuad(TILE_W * 1, 0, TILE_W, TILE_H, border_tiles)
	for y = 1, MAP_H do
		love.graphics.draw(border_tiles, quad, (MAP_W + 1) * TILE_W, y * TILE_H)
	end

	-- left
	quad = love.graphics.newQuad(TILE_W * 2, 0, TILE_W, TILE_H, border_tiles)
	for x = 1, MAP_W do
		love.graphics.draw(border_tiles, quad, x * TILE_W, 0)
	end

	-- right
	quad = love.graphics.newQuad(TILE_W * 3, 0, TILE_W, TILE_H, border_tiles)
	for x = 1, MAP_W do
		love.graphics.draw(border_tiles, quad, x * TILE_W, (MAP_H + 1) * TILE_H)
	end
	
	-- bottom-left
	quad = love.graphics.newQuad(TILE_W * 4, 0, TILE_W, TILE_H, border_tiles)
	love.graphics.draw(border_tiles, quad, 0 * TILE_W, 14 * TILE_H)	

	-- bottom-right
	quad = love.graphics.newQuad(TILE_W * 5, 0, TILE_W, TILE_H, border_tiles)
	love.graphics.draw(border_tiles, quad, 16 * TILE_W, 14 * TILE_H)	

	-- top-right
	quad = love.graphics.newQuad(TILE_W * 6, 0, TILE_W, TILE_H, border_tiles)
	love.graphics.draw(border_tiles, quad, 16 * TILE_W, 0 * TILE_H)	

	-- top-left
	quad = love.graphics.newQuad(TILE_W * 7, 0, TILE_W, TILE_H, border_tiles)
	love.graphics.draw(border_tiles, quad, 0 * TILE_W, 0 * TILE_H)	

	-- reset canvas
	love.graphics.setCanvas()

	return canvas
end

function getMonsterTexture(char)
	if char == 'A' then return 'gfx/Soldier.png'
	elseif char == 'B' then return 'gfx/Lizzy.png'
	elseif char == 'C' then return 'gfx/Sarge.png'
	elseif char == 'D' then return 'gfx/Taur.png'
	elseif char == 'E' then return 'gfx/Gunner.png'
	elseif char == 'F' then return 'gfx/Giggler.png'
	elseif char == 'G' then return 'gfx/Ghost.png'
	elseif char == 'H' then return 'gfx/Skully.png'
	elseif char == 'I' then return 'gfx/Smoulder.png'
	elseif char == 'J' then return 'gfx/Thing.png'
	elseif char == '*' then return 'gfx/Head Boss.png'
	else error('not implemented ' .. char)
	end
end

function Level:init(index)
	self.entities = {}

	if not levels_data then
		local contents, _ = love.filesystem.read('dat/levels.json')
		levels_data = json.decode(contents)['LevelDescription']
	end

	self.index = index < #levels_data and index or 1

	local level_data = levels_data[index]

	local bg_pattern_id = level_data['BGPatternID']
	local border_id = level_data['BorderID']
	local fixed_block_id = level_data['FixedBlockID']
	local breakable_block_id = level_data['BreakableBlockID']

	self.background = generateBackground(bg_pattern_id, border_id)

	local time = level_data['Time']

	local grid_desc_str = level_data['GridDescString']
	local x, y = 1, 1

	local map = {{}}

	for i = 1, #grid_desc_str do
		local c = string.sub(grid_desc_str, i, i)

		if c == '0' then 
			goto continue 
		elseif c == 'X' then
			map[y][x] = Player({ texture = 'gfx/Player1.png', x = x * TILE_W, y = y * TILE_H })
			table.insert(self.entities, map[y][x])
		elseif c == 'Y' then
			map[y][x] = Player({ texture = 'gfx/Player2.png', x = x * TILE_W, y = y * TILE_H })
			table.insert(self.entities, map[y][x])
		elseif c == '+' then
			map[y][x] = Teleporter({ texture = 'gfx/Teleporter.png', x = x * TILE_W, y = y * TILE_H })
			table.insert(self.entities, map[y][x])
		elseif c == '1' then
			map[y][x] = FixedBlock({ texture = 'gfx/Fixed Blocks.png', x = x * TILE_W, y = y * TILE_H })
			table.insert(self.entities, map[y][x])
		elseif c == '2' then
			map[y][x] = BreakableBlock({ texture = 'gfx/Breakable Blocks.png', x = x * TILE_W, y = y * TILE_H })
			table.insert(self.entities, map[y][x])
		elseif c == '3' then
			map[y][x] = Coin({ texture = 'gfx/Coin.png', x = x * TILE_W, y = y * TILE_H })
			table.insert(self.entities, map[y][x])
		else
			map[y][x] = Monster({ texture = getMonsterTexture(c), x = x * TILE_W, y = y * TILE_H })
			table.insert(self.entities, map[y][x])			
		end

		::continue::

		x = x + 1

		if x > MAP_W then
			y = y + 1
			x = 1

			map[y] = {}
		end
	end
end

function Level:draw()
	love.graphics.draw(self.background)

	for _, entity in ipairs(self.entities) do
		entity:draw()
	end
end

function Level:update(dt)
	-- body
end
