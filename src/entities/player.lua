Player = Entity:extend()

function Player:new(x, y, index)
	Player.super.new(self, x, y)

	self._index = index
end

function Player:index()
	return self._index
end