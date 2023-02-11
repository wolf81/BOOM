--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local Collider = require 'src.utility.collider'

local table_insert, lume_remove, math_max = table.insert, lume.remove, math.max

Level = Class {}

local function isCollidable(entity)
	return entity.category_flags ~= 0
end

local function transformMonsters(self)
	for _, monster in ipairs(self.monsters) do
		local alien = EntityFactory.create('alien', monster.pos.x, monster.pos.y)
		alien.monster = EntityFactory.getKey(monster.name)
		self:removeEntity(monster)
		self:addEntity(alien)
	end
end

local function transformAliens(self)
	for _, alien in ipairs(self.monsters) do
		local monster = EntityFactory.create(alien.monster, alien.pos.x, alien.pos.y)
		self:addEntity(monster)
		self:removeEntity(alien)
	end
end

local function updateTeleporterTargets(self)
	if #self.teleporters < 2 then return end

	for idx = 1, #self.teleporters - 1 do
		local teleporter1 = self.teleporters[idx]
		local teleporter2 = self.teleporters[idx + 1]
		teleporter2:setTarget(teleporter1)
	end

	self.teleporters[1]:setTarget(self.teleporters[#self.teleporters])
end

local function insertEntities(self)
	for _, entity in ipairs(self.insert_queue) do
		if entity:is(Explosion) then table_insert(self.explosions, entity)
		elseif entity:is(Projectile) then table_insert(self.projectiles, entity)
		elseif entity:is(Bomb) then table_insert(self.bombs, entity)
		elseif entity:is(Block) then table_insert(self.fixed_blocks, entity)
		elseif entity:is(BreakableBlock) then table_insert(self.breakable_blocks, entity)
		elseif entity:is(Player) then table_insert(self.players, entity)
		elseif entity:is(Monster) then table_insert(self.monsters, entity)
		elseif entity:is(Teleporter) then table_insert(self.teleporters, entity)
		elseif entity:is(Coin) then table_insert(self.coins, entity)
		elseif entity:is(Bonus) then table_insert(self.bonuses, entity)
		elseif entity:is(Flash) or entity:is(Points1K) or entity:is(Points5K) or entity:is(Points100K) then table_insert(self.props, entity)
		elseif entity:is(Extra) then table_insert(self.extras, entity)
		end
	end

	self.insert_queue = {}
end

local function removeEntities(self)
	for _, entity in ipairs(self.remove_queue) do
		if entity:is(Explosion) then lume_remove(self.explosions, entity)
		elseif entity:is(Projectile) then lume_remove(self.projectiles, entity)
		elseif entity:is(Bomb) then lume_remove(self.bombs, entity)
		elseif entity:is(Block) then lume_remove(self.fixed_blocks, entity)
		elseif entity:is(BreakableBlock) then
			lume_remove(self.breakable_blocks, entity)
			local grid_pos = entity:gridPosition()
			self.grid:unblock(grid_pos.x, grid_pos.y)
		elseif entity:is(Player) then -- lume_remove(self.players, entity) -- TODO: respawn after delay
		elseif entity:is(Monster) then lume_remove(self.monsters, entity)
		elseif entity:is(Teleporter) then lume_remove(self.teleporters, entity)
		elseif entity:is(Coin) then lume_remove(self.coins, entity)
		elseif entity:is(Bonus) then lume_remove(self.bonuses, entity)
		elseif entity:is(Flash) or entity:is(Points1K) or entity:is(Points5K) or entity:is(Points100K) then lume_remove(self.props, entity)
		elseif entity:is(Extra) then lume_remove(self.extras, entity)
		end
	end

	self.remove_queue = {}
end

local function tryTeleportEntities(self, teleporter)
	local busy = false
	local grid_pos = teleporter:gridPosition()

	local fn = function(entity)
		if entity:gridPosition() == grid_pos then
			busy = true

			if teleporter.pos:dist2(entity.pos) < 5 then
				teleporter:teleport(entity)
			end
		end
	end

	for _, monster in ipairs(self.monsters) do fn(monster) end
	for _, player in ipairs(self.players) do fn(player) end

	teleporter.busy = busy
end

local function onCollide(entity1, entity2)
	if entity1:is(Projectile) then
		-- TODO: add wall/border collider, perhaps inverse of a rectangle (inside ok, outside remove)
		entity1:destroy()
		if entity2:is(Player) then entity2:hit(entity1.damage) end
	elseif entity2:is(Projectile) then
		entity2:destroy()
		if entity1:is(Player) then entity1:hit(entity2.damage) end
	elseif entity1:is(Monster) and entity2:is(Monster) then
		entity2:onCollision(entity1)
		entity1:onCollision(entity2)
	elseif entity1:is(Coin) and entity2:is(Player) then
		entity1:destroy()
		-- TODO: add points to player
	elseif entity1:is(Player) and entity2:is(Coin) then
		entity2:destroy()
		-- TODO: add points to player
	elseif entity1:is(Bonus) and entity2:is(Player) then
		entity1:apply(entity2)
		entity1:destroy()
		-- TODO: give bonus to player
	elseif entity1:is(Player) and entity2:is(Bonus) then
		entity2:apply(entity1)
		entity2:destroy()
		-- TODO: give bonus to player
	elseif entity1:is(Explosion) then
		entity2:hit(entity1.damage)
	elseif entity2:is(Explosion) then
		entity1:hit(entity2.damage)
	elseif entity1:is(Extra) then
		entity1:apply(entity2)
		entity1:destroy()
	elseif entity2:is(Extra) then
		entity2:apply(entity1)
		entity2:destroy()
	end
end

function Level:init(index, grid, time, entities)
	self.index = index
	self.grid = grid
	self.time = time

	self.collider = Collider(onCollide)

	self.fixed_blocks = {}
	self.breakable_blocks = {}
	self.players = {}
	self.coins = {}
	self.bonuses = {}
	self.extras = {}
	self.bombs = {}
	self.explosions = {}
	self.projectiles = {}
	self.teleporters = {}
	self.monsters = {}
	self.props = {}

	self.insert_queue = {}
	self.remove_queue = {}

	self.extra_duration = 0

	self.flags = 0

	for _, entity in ipairs(entities) do self:addEntity(entity) end
	insertEntities(self)

	updateTeleporterTargets(self)

	AudioPlayer.playMusic('mus/BOOM Music ' .. math.ceil(self.index / 10) .. '.wav')

	-- TODO: use shash module for collision checking, likely more efficient

	print('level ' .. self.index)
	print(self.grid)
end

function Level:serialize()
	local entities = {}

	for _, player in ipairs(self.players) do
		table_insert(entities, player:serialize())
	end

	for _, monster in ipairs(self.monsters) do
		table_insert(entities, monster:serialize())
	end

	for _, fixed_block in ipairs(self.fixed_blocks) do
		table_insert(entities, fixed_block:serialize())
	end

	for _, breakable_block in ipairs(self.breakable_blocks) do
		table_insert(entities, breakable_block:serialize())
	end

	for _, bomb in ipairs(self.bombs) do
		table_insert(entities, bomb:serialize())
	end

	for _, explosion in ipairs(self.explosions) do
		table_insert(entities, explosion:serialize())
	end

	for _, coin in ipairs(self.coins) do
		table_insert(entities, coin:serialize())
	end

	return { index = self.index, grid = self.grid:serialize(), time = self.time, entities = entities }
end

function Level.deserialize(obj)
	local entities = {}
	for _, entity in ipairs(obj.entities) do
		table_insert(entities, EntityFactory.deserialize(entity))
	end

	local grid = Grid.deserialize(obj.grid)
	local level = Level(obj.index, grid, obj.time, entities)

	return level
end

function Level:addEntity(entity)
	table_insert(self.insert_queue, entity)

	entity.level = self

	entity:spawn()

	if entity:is(Player) then
		self:addEntity(EntityFactory.create('flash', entity.pos.x, entity.pos.y))
	end

	if isCollidable(entity) then
		self.collider:add(entity)
	end
end

function Level:removeEntity(entity)
	table_insert(self.remove_queue, entity)

	if isCollidable(entity) then
		self.collider:remove(entity)
	end
end

function Level:getBreakableBlock(grid_pos)
	for _, entity in ipairs(self.breakable_blocks) do
		if entity:gridPosition() == grid_pos then return entity end
	end

	return nil
end

function Level:getBomb(grid_pos)
	for _, entity in ipairs(self.bombs) do
		if entity:gridPosition() == grid_pos then return entity end
	end

	return nil
end

function Level:eachGridPosition(fn)
	local width, height = self.grid:size()

	for x = 1, width do
		for y = 1, height do
			fn(vector(x, y))
		end
	end
end

function Level:destroyBlocks()
	local delay = 0.0

	self:eachGridPosition(function(pos)
		local bblock = self:getBreakableBlock(pos)
		if bblock then Timer.after(delay, function() bblock:destroy() end) end
		delay = delay + 0.01
	end)
end

function Level:destroyMonsters()
	for _, monster in ipairs(self.monsters) do
		monster:destroy()
	end
end

-- TODO: use a vector instead of x, y coords to align with getBreakableBlock(), getBomb()
function Level:isBlocked(x, y)
	return self.grid:isBlocked(x, y)
end

function Level:update(dt)
	Overlay.update(dt)

	self.time = math_max(self.time - dt, 0)

	if self.time <= 30.0 and not HasFlag(self.flags, LevelFlags.DID_SHOW_HURRY) then
		Overlay.show('gfx/Hurry Up.png', 'sfx/HurryUp.wav')
		self.flags = SetFlag(self.flags, LevelFlags.DID_SHOW_HURRY)
		-- TODO: when time reaches 0, speed up monsters
	end

	insertEntities(self)

	for _, entity in ipairs(self.teleporters) do
		entity:update(dt)

		tryTeleportEntities(self, entity)
	end

	for _, entity in ipairs(self.coins) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.bonuses) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.extras) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.bombs) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.explosions) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.monsters) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.players) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.fixed_blocks) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.breakable_blocks) do
		entity:update(dt)
	end

	for _, entity in ipairs(self.projectiles) do
		-- destroy projectiles that go outside of map bounds
		-- would be nicer to fix in Collider, but that might
		-- need some optimalization first
		local x, y, w, h = entity:getFrame()
		if x < TILE_W or y < TILE_H or x > MAP_W * TILE_W + TILE_W / 2 or y > MAP_H * TILE_H + TILE_H / 2 then
			entity:destroy()
		end

		entity:update(dt)
	end

	for _, entity in ipairs(self.props) do
		entity:update(dt)
	end

	self.collider:update()

	removeEntities(self)

	-- TODO: should show when colliding with last coin
	if #self.coins == 0 and not HasFlag(self.flags, LevelFlags.DID_SHOW_EXTRA) and #self.monsters > 0 then
		Overlay.show('gfx/EXTRA Game.png', 'sfx/EXTRAGame.wav')
		self.flags = SetFlag(self.flags, LevelFlags.DID_SHOW_EXTRA)

		transformMonsters(self)
		self.extra_duration = 30
	end

	if self.extra_duration > 0 then
		self.extra_duration = math_max(self.extra_duration - dt, 0)

		if self.extra_duration == 0 then
			transformAliens(self)
		end
	end
end

function Level:draw()
	for _, entity in ipairs(self.teleporters) do
		entity:draw()
	end

	for _, entity in ipairs(self.coins) do
		entity:draw()
	end

	for _, entity in ipairs(self.bonuses) do
		entity:draw()
	end

	for _, entity in ipairs(self.extras) do
		entity:draw()
	end

	for _, entity in ipairs(self.bombs) do
		entity:draw()
	end

	for _, entity in ipairs(self.explosions) do
		entity:draw()
	end

	for _, entity in ipairs(self.monsters) do
		entity:draw()
	end

	for _, entity in ipairs(self.players) do
		entity:draw()
	end

	for _, entity in ipairs(self.fixed_blocks) do
		entity:draw()
	end

	for _, entity in ipairs(self.breakable_blocks) do
		entity:draw()
	end

	for _, entity in ipairs(self.projectiles) do
		entity:draw()
	end

	for _, entity in ipairs(self.props) do
		entity:draw()
	end

	Overlay.draw()
end
