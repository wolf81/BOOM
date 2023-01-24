Teleporter = Class { __includes = EntityBase }

function Teleporter:init(def)
	EntityBase.init(self, def)

	print('teleporter')
end