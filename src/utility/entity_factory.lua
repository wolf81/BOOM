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

local name_key_info = {}

local key_type_info = {
	['1'] = Block,
	['2'] = BreakableBlock,
	['3'] = Coin,
	['X'] = Player,
	['Y'] = Player,
	['+'] = Teleporter,
	['bomb'] = Bomb,
	['flash'] = Flash,
	['explosion'] = Explosion,
	['shot'] = Projectile,
	['fireball'] = Projectile,
	['lightbolt'] = Projectile,
	['mg_shot'] = Projectile,
	['magma'] = Projectile,
	['plasma'] = Projectile,
	['flame'] = Projectile,
	['head-missile'] = Projectile,
	['alien-egg'] = Projectile,
	['points1k'] = Points1K,
	['points5k'] = Points5K,
	['points100k'] = Points100K,
	['shield'] = Shield,
	['extra'] = Extra,
	['bonus'] = Bonus,
	['head-boss'] = Boss,
	['alien-boss'] = Boss,
}

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
		entity_def.key = key

		name_key_info[entity_def.name] = key
		local T = key_type_info[key] or Monster
		prototypes[key] = T(entity_def)

		prototypes[key]:prepare(entity_def)
	end
end

function EntityFactory.getKey(name)
	return name_key_info[name]
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

function EntityFactory.deserialize(obj, ...)
	assert(obj.key ~= nil, 'key is required')

	local T = key_type_info[obj.key] or Monster
	return T.deserialize(obj, ...)
end
