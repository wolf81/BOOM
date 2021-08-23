Monster = Entity:extend()

function Monster:new(data)
	print('init monster')

	Monster.super.new(self, data)
end