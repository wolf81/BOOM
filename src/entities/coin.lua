Coin = Class { __includes = Entity }

function Coin:init(def)
	Entity.init(self, def)

	print('coin')
end