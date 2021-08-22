Monster = Entity:extend()

function Monster:new(x, y)
	Monster.super.new(self, x, y)
	print('init monster')
end