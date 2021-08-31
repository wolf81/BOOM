Player = Creature:extend()

local BOMB_COUNT_DEFAULT = 5
local BOMB_COUNT_MAX = 8
local SPEED_DEFAULT = 2
local HEALTH_MAX = 16
local LIVES_DEFAULT = 3

function Player:new(data)
	Player.super.new(self, data)

	self._index = data.id == "X" and 1 or 2

	self._health = HEALTH_MAX
	self._speed = SPEED_DEFAULT
	self._lives = LIVES_DEFAULT

	self._bonuses = {
		0, 0, 0, 0, 0,
	}
end

function Player:health()
	return self._health
end

function Player:lives()
	return self._lives
end

function Player:bonuses()
	return self._bonuses
end

function Player:index()
	return self._index
end

function Player:update(dt)
	Player.super.update(self, dt)	
end

function Player:dropBomb()
	local position = self:position() + TileSize / 2
	self:level():addBomb(position)
end