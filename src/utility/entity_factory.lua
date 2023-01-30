--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local IdGenerator = require 'src.utility.id_generator'

EntityFactory = {}

-- TODO: would be cleaner to call something like IdGenerator.new()
-- in line with rest of the code base
local id_generator = IdGenerator()

local prototypes = {}

-- register all entities at the given path
-- will also preload images for all entities
function EntityFactory.register(path)
	assert(path ~= nil, 'path to definition file required')

	-- ensure entity_defs.lua is loaded
	local dir = love.filesystem.getRealDirectory(path)
	local fn = assert(loadfile(dir .. path))
	local entity_defs = fn()

	for key, entity_def in pairs(entity_defs) do
		if key == '1' then 
			prototypes[key] = Block(entity_def)
		elseif key == '2' then 
			prototypes[key] = BreakableBlock(entity_def)
		elseif key == '3' then 
			prototypes[key] = Coin(entity_def)
		elseif key == 'X' or key == 'Y' then
			prototypes[key] = Player(entity_def)
		elseif key == '+' then 
			prototypes[key] = Teleporter(entity_def)
		elseif key == 'bomb' then
			prototypes[key] = Bomb(entity_def)
		elseif key == 'flash' then
			prototypes[key] = Flash(entity_def)
		elseif key == 'explosion' then
			prototypes[key] = Explosion(entity_def)
		else
			prototypes[key] = Creature(entity_def)
		end			

		-- preload textures
		ImageCache.load(entity_def.texture)
	end
end

-- generate an entity based on key, level & x, y coords
function EntityFactory.create(key, x, y, ...)
	assert(key ~= nil, 'key is required')
	assert(x ~= nil and y ~= nil, 'x and y value is required')
	assert(prototypes[key] ~= nil, 'key \"' .. key .. '\" not registered')

	local entity = CopyTable(prototypes[key])
	entity:config(id_generator.next(), x, y, ...)
	return entity
end
