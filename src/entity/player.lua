Player = Class { __includes = EntityBase }

function Player:init(def)
	EntityBase.init(self, def)

	print('player')
end
