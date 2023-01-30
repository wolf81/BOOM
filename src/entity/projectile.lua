Projectile = Class { __includes = EntityBase }

function Projectile:init(def)
	EntityBase.init(self, def)
end

function Projectile:config(id, x, y)
	EntityBase.config(self, id, x, y)
	
end