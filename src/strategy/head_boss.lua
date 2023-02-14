--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

HeadBoss = Class { __includes = StrategyBase }

local ATTACK_DELAY = 3.0

local function getDirection(pos1, pos2)
	return pos2:angleTo(pos1)
end

function HeadBoss:init(entity)
	StrategyBase.init(self, entity)

	self.attack_delay = ATTACK_DELAY / 2.0

	print('projectile', entity.projectile)
end

function HeadBoss:update(dt)
	if self.entity:isDestroyed() then return end

	self.attack_delay = math_max(self.attack_delay - dt, 0)

	local mid_x = self.entity.pos.x + self.entity.size.x / 2
	local mid_y = self.entity.pos.y + self.entity.size.y / 2
	local mid = vector(mid_x, mid_y)

	if self.attack_delay == 0 then
		print('attack')

		local player1 = self.entity.level.players[1]
		local player2 = self.entity.level.players[2]
		local dist_p1 = player1.pos:dist2(mid)
		local dist_p2 = player2.pos:dist2(mid)

		local target = (dist_p1 < dist_p2) and player1 or player2

		local eye_pos1 = vector(self.entity.pos.x + 20, self.entity.pos.y + 20)
		local eye_pos2 = vector(self.entity.pos.x + self.entity.size.x - 20, self.entity.pos.y + 20)
		local dir1 = math.atan2(eye_pos1.x - target.pos.x, target.pos.y - eye_pos1.y) + math.pi / 2

		local vec1 = vector(math.cos(dir1), math.sin(dir1))
		local missile1 = EntityFactory.create(self.entity.projectile, eye_pos1.x, eye_pos1.y, vec1)
		missile1.collision_flags = CategoryFlags.PLAYER
		self.entity.level:addEntity(missile1)

		local dir2 = math.atan2(eye_pos2.x - target.pos.x, target.pos.y - eye_pos2.y) + math.pi / 2
		local vec2 = vector(math.cos(dir2), math.sin(dir2))
		local missile2 = EntityFactory.create(self.entity.projectile, eye_pos2.x, eye_pos2.y, vec2)
		missile2.collision_flags = CategoryFlags.PLAYER
		self.entity.level:addEntity(missile2)

		self.attack_delay = ATTACK_DELAY
	else
		-- print()
	end
end
