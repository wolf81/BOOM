--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

PlayerControl = Class {}

-- TODO: it feels better to keep showing movement animation even if walking towards blocked position
-- perhaps we can achieve this by checking to target pos in Move state instead of here
local function getDirection(self, direction)
	return direction
end

function PlayerControl:init(entity)
	self.entity = entity
end

function PlayerControl:update(dt)	
	local direction = Direction.NONE	

	-- if vertically aligned with tiles, allow movement in horizontal directions
	if self.entity.pos.y % TILE_H == 0 then
		if love.keyboard.isDown('left') then direction = getDirection(self, Direction.LEFT)
		elseif love.keyboard.isDown('right') then direction = getDirection(self, Direction.RIGHT)
		end
	end

	-- if horizontally aligned with tiles, allow movement in vertical directions
	if self.entity.pos.x % TILE_W == 0 then
		if love.keyboard.isDown('up') then direction = getDirection(self, Direction.UP)
		elseif love.keyboard.isDown('down') then direction = getDirection(self, Direction.DOWN)
		end
	end

	if direction ~= Direction.NONE then
		self.entity:move(direction)
	else
		-- if direction is none, don't stop immediately, but make entity stop moving when 
		-- reaching target position for current move
		self.entity.direction = Direction.NONE
	end
end
