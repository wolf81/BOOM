Teleporter = Class { __includes = Entity }

function Teleporter:init(def)
	Entity.init(self, def)

	print('teleporter')
end