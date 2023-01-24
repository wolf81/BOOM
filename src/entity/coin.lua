Coin = Class { __includes = EntityBase }

function Coin:init(def)
	EntityBase.init(self, def)

	print('coin')
end