BreakableBlock = Class { __includes = Entity }

function BreakableBlock:init(def)
	Entity.init(self, def)

	print('breakable block')
end


