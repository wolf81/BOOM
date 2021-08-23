Monster = Entity:extend()

function Monster:new()
	Monster.super.new(self)
	print('init monster')
end