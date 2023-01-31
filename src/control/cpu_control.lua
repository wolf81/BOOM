--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_keys, lume_match, string_find, math_abs = lume.keys, lume.match, string.find, math.abs

CpuControl = Class {}

local MELEE_ATTACK_RANGE = 0.8

local DIRS = {
	Direction.UP,
	Direction.DOWN,
	Direction.LEFT,
	Direction.RIGHT
}

local function tryAttack(monster, range)
	if monster.projectile then
		monster:attack() 
	elseif range <= MELEE_ATTACK_RANGE then
		monster:attack() 
	end
end

local function idling(self, dt)
	-- body
end

local function roaming(self, dt)
	if self.entity:isDestroyed() or self.entity:isAttacking() then return end

	if self.entity.direction ~= Direction.NONE and self.entity:canAttack() then
		local grid_pos = self.entity:gridPosition()

		local did_attack = false

		for _, player in ipairs(self.entity.level.players) do
			local player_grid_pos = player:gridPosition()

			if self.entity.direction == Direction.UP then
				if player_grid_pos.x == grid_pos.x and player_grid_pos.y <= grid_pos.y then 
					tryAttack(self.entity, math_abs(player_grid_pos.y - grid_pos.y))
				end
			elseif self.entity.direction == Direction.DOWN then
				if player_grid_pos.x == grid_pos.x and player_grid_pos.y >= grid_pos.y then 
					tryAttack(self.entity, math_abs(player_grid_pos.y - grid_pos.y))
				end
			elseif self.entity.direction == Direction.LEFT then
				if player_grid_pos.y == grid_pos.y and player_grid_pos.x <= grid_pos.x then 
					tryAttack(self.entity, math_abs(player_grid_pos.x - grid_pos.x))					
				end
			elseif self.entity.direction == Direction.RIGHT then
				if player_grid_pos.y == grid_pos.y and player_grid_pos.x >= grid_pos.x then 
					tryAttack(self.entity, math_abs(player_grid_pos.x - grid_pos.x))					
				end
			end

			if self.entity:isAttacking() then return end
		end
	end

	if self.entity.pos.x % TILE_W == 0 and self.entity.pos.y % TILE_H == 0 then
		local dirs = lume.shuffle(DIRS)
		local dir = Direction.NONE

		-- loop through each direction, finding the first unblocked direction
		while #dirs > 0 do
			-- TODO: for alien boss at level 80, we also need to take into
			-- account the sprite size, to see whether we hit a block
			local direction = table.remove(dirs)
			local to_grid_pos = self.entity:gridPosition() + direction
			if not self.entity.level:isBlocked(to_grid_pos.x, to_grid_pos.y) then
				dir = direction
				break
			end
		end

		self.entity:move(dir)
	end	
end

function CpuControl:init(entity)
	self.entity = entity

	local has_move_anims = lume_match(lume_keys(entity.animations), function(key) return string_find(key, 'move') end)
	self.update = has_move_anims and roaming or idling
end

function CpuControl:update(dt)	
	-- an update function is assigned on initialization
end
