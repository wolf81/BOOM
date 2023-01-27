--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

EntityFactory = {}

local prototypes = {}

-- register all entities at the given path
-- will also preload images for all entities
function EntityFactory.register(path)
	assert(path ~= nil, 'path to definition file required')

	print('load entities')

	-- ensure entity_defs.lua is loaded
	local dir = love.filesystem.getRealDirectory(path)
	local fn = assert(loadfile(dir .. path))
	local entity_defs = fn()

	for key, entity_def in pairs(entity_defs) do
		if key == '1' then 
			prototypes[key] = FixedBlock(entity_def)
		elseif key == '2' then 
			prototypes[key] = BreakableBlock(entity_def)
		elseif key == '3' then 
			prototypes[key] = Coin(entity_def)
		elseif key == 'X' or key == 'Y' then
			prototypes[key] = Player(entity_def)
		elseif key == '+' then 
			prototypes[key] = Teleporter(entity_def)
		else
			prototypes[key] = Creature(entity_def)
		end			

		-- preload textures
		ImageCache.load(entity_def.texture)
	end
end

-- generate an entity based on key and x, y coords
function EntityFactory.create(key, x, y)
	assert(key ~= nil, 'key is required')
	assert(prototypes[key] ~= nil, 'key \"' .. key .. '\" not registered')
	assert(x ~= nil and y ~= nil, 'x and y value is required')

	local entity = CopyTable(prototypes[key])
	entity.pos = vector(x, y)
	return entity
end
