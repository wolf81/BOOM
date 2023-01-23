Monster = Class { __includes = Entity }

function Monster:init(def)
	Entity.init(self, def)

	print('monster')
end
