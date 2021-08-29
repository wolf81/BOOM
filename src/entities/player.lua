Player = Creature:extend()

function Player:new(data)
	Player.super.new(self, data)

	self._index = data.id == "X" and 1 or 2
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