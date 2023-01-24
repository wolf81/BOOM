Monster = Class { __includes = EntityBase }

function Monster:init(def)
	EntityBase.init(self, def)

	print('monster')
end
