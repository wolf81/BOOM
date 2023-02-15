--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, math_atan2, math_cos, math_sin = math.max, math.atan2, math.cos, math.sin
local table_insert, table_sort, bit_bor, lume_shuffle = table.insert, table.sort, bit.bor, lume.shuffle

HeadBoss = Class { __includes = StrategyBase }

local MATH_PI_2 = math.pi / 2

local ATTACK_DELAY_LONG = 3.0
local ATTACK_DELAY_SHORT = 0.5
local MISSILE_COUNT = 3

function fireMissile(self, origin, target)
	local dir = math_atan2(origin.x - target.x, target.y - origin.y) + MATH_PI_2
	local missile = EntityFactory.create(
		self.entity.projectile,
		origin.x, origin.y,
		vector(math_cos(dir), math_sin(dir))
	)
	missile.collision_flags = bit_bor(CategoryFlags.PLAYER, CategoryFlags.MONSTER)
	self.entity.level:addEntity(missile)
end

function HeadBoss:init(entity)
	StrategyBase.init(self, entity)

	self.attack_delay = ATTACK_DELAY_LONG
	self.missile_count = 3

	self.mid_pos = self.entity.pos + self.entity.size / 2
	self.eye_pos_list = {
		vector(self.entity.pos.x + 20, self.entity.pos.y + 20),
		vector(self.entity.pos.x + self.entity.size.x - 20, self.entity.pos.y + 20)
	}

	print('projectile', entity.projectile)
end

function HeadBoss:update(dt)
	if self.entity:isDestroyed() then return end

	self.attack_delay = math_max(self.attack_delay - dt, 0)

	if self.attack_delay > 0 then return end

	-- get players sorted by distance from mid point of boss
	local players = {}
	for _, player in ipairs(self.entity.level.players) do
		if not player:isDestroyed() then
			local player_mid_pos = player.pos + player.size / 2
			table_insert(players, {
				target = player,
				dist = player_mid_pos:dist2(self.mid_pos)
			})
			players = lume.shuffle(players)
		end
	end

	-- fire missiles to nearest player
	if #players > 0 then
		table_sort(players, function(a, b) return a.dist < b.dist end)

		local target = players[1].target
		for _, eye_pos in ipairs(self.eye_pos_list) do
			fireMissile(self, eye_pos, target.pos)
		end
	end

	-- shoot 3 missiles from each eye in short succession, then wait
	self.missile_count = math_max(self.missile_count - 1, 0)
	if self.missile_count == 0 then
		self.attack_delay = ATTACK_DELAY_LONG
		self.missile_count = MISSILE_COUNT
	else
		self.attack_delay = ATTACK_DELAY_SHORT
	end
end
