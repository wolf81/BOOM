Player = Entity:extend()

function Player:new(data)
	print('init player')

	Player.super.new(self, data)

	self._index = 1
end

function Player:index()
	return self._index
end

function Player:setIndex(index)
	self._index = index or 1
end