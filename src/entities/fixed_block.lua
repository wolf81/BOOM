FixedBlock = Class { __includes = Entity }

function FixedBlock:init(def)
	Entity.init(self, def)

	print('fixed block')
end
