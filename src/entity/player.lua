Player = Class { __includes = Creature }

function Player:init(def, x, y)
	Creature.init(self, def, x, y)
	
	self.z_index = 10
	self.control = PlayerControl(self)
end
