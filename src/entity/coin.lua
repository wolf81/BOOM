--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Coin = Class { __includes = EntityBase }

function Coin:init(def)
	EntityBase.init(self, def)

	self.category_flags = Category.COIN
end

function Coin:destroy()
	EntityBase.destroy(self)

	self.level:addEntity(EntityFactory.create('points', self.pos.x, self.pos.y))	
end