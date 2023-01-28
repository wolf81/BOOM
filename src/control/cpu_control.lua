--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_keys, lume_match, string_find = lume.keys, lume.match, string.find

CpuControl = Class {}

local DIRS = {
	Direction.UP,
	Direction.DOWN,
	Direction.LEFT,
	Direction.RIGHT
}

local function idling(self, dt)
	-- body
end

local function roaming(self, dt)
	if self.entity.pos.y % TILE_H == 0 and self.entity.pos.x % TILE_W == 0 then
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
