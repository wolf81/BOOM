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

function Player:applyBonus(bonus)
	if bonus:isApplied() then return end
	bonus:setApplied()

	local bonusId = bonus._data.id

	print('apply bonus: ' .. bonus._data.id)

	if bonusId == 'b_bombs' then
		self._bonuses[1] = self._bonuses[1] + 1
	elseif bonusId == 'b_fuse' then
		self._bonuses[2] = self._bonuses[2] + 1
	elseif bonusId == 'b_explode_radius' then
		self._bonuses[3] = self._bonuses[3] + 1
	elseif bonusId == 'b_shield' then
		self._bonuses[4] = math.max(self._bonuses[4] + 1, 1)
	elseif bonusId == 'b_speed' then
		self._bonuses[5] = math.max(self._bonuses[5] + 1, 1)
	elseif bonusId == 'b_heal_big' then
		self._health = HEALTH_MAX
	elseif bonusId == 'b_heal_small' then
		self._health = math.min(self._health + 1, HEALTH_MAX)
	elseif bonusId == 'b_kill' then
	elseif bonusId == 'b_zap' then
	end
end

function Player:health()
	return self._health
end

function Player:lives()
	return self._lives
end

function Player:move(direction)
	if self._stateMachine:currentStateName() == 'cheer' then return false end

	Player.super.move(self, direction)
end

function Player:cheer()
	if self._stateMachine:currentStateName() == 'cheer' then return false end

	local stateInfo = self._data.states.cheer
	local params = { entity = self, stateInfo = stateInfo }

	self._stateMachine:change('cheer', params)
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