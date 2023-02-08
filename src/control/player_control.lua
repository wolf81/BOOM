--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local baton = require 'lib.baton.baton'

local lume_round = lume.round

local P1_CONFIG = {
	controls = {
		left = { 'key:a', 'axis:leftx-', 'button:dpleft' },
		right = { 'key:d', 'axis:leftx+', 'button:dpright' },
		up = { 'key:w', 'axis:lefty-', 'button:dpup' },
		down = { 'key:s', 'axis:lefty+', 'button:dpdown' },
		action = { 'key:space', 'button:a' },
	},
	pairs = {},
	joystick = love.joystick.getJoysticks()[1]
}

local P2_CONFIG = {
	controls = {
		left = { 'key:left', 'axis:leftx-', 'button:dpleft' },
		right = { 'key:right', 'axis:leftx+', 'button:dpright' },
		up = { 'key:up', 'axis:lefty-', 'button:dpup' },
		down = { 'key:down', 'axis:lefty+', 'button:dpdown' },
		action = { 'key:return', 'button:a' },
	},
	pairs = {},
	joystick = love.joystick.getJoysticks()[2]
}


PlayerControl = Class {}

-- TODO: it feels better to keep showing movement animation even if walking towards blocked position
-- perhaps we can achieve this by checking to target pos in Move state instead of here
local function getDirection(self, direction)
	return direction
end

function PlayerControl:init(entity)
	self.entity = entity

	local config = entity.name == 'Player 1' and P1_CONFIG or P2_CONFIG

	self.input = baton.new(config)
end

function PlayerControl:update(dt)	
	self.input:update()

	local is_x_aligned = self.entity.pos.x % TILE_W == 0
	local is_y_aligned = self.entity.pos.y % TILE_H == 0

	if self.entity:isIdling() and not self.entity.direction then
		if not is_x_aligned then
			local dir = ((self.entity.pos.x % TILE_W) < TILE_W / 2) and Direction.RIGHT or Direction.LEFT
			self.entity:move(nil)
		elseif not is_y_aligned then
			local dir = ((self.entity.pos.x % TILE_H) < TILE_H / 2) and Direction.DOWN or Direction.UP
			self.entity:move(nil)
		end
	end

	if self.entity:isDestroyed() or self.entity:isHit() then return end

	if self.input:pressed('action') then
		self.entity:tryDropBomb()
	end

	local direction = nil

	-- if vertically aligned with tiles, allow movement in horizontal directions
	if is_y_aligned then
		if self.input:down('left') then direction = getDirection(self, Direction.LEFT)
		elseif self.input:down('right') then direction = getDirection(self, Direction.RIGHT)
		end
	end

	-- if horizontally aligned with tiles, allow movement in vertical directions
	if is_x_aligned then
		if self.input:down('up') then direction = getDirection(self, Direction.UP)
		elseif self.input:down('down') then direction = getDirection(self, Direction.DOWN)
		end
	end

	if direction then
		self.entity:move(direction)
	else
		-- if direction is none, don't stop immediately, but make entity stop moving when 
		-- reaching target position for current move
		self.entity.direction = nil
	end
end
