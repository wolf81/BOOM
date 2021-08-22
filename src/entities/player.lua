Player = Entity:extend()

function Player:new(x, y)
	Player.super.new(self, x, y)
	print('init player')
end