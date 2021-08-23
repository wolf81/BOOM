Player = Entity:extend()

function Player:new(index)
	Player.super.new(self)

	self._index = index
end

function Player:index()
	return self._index
end