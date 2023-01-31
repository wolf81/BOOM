Projectile = Class { __includes = EntityBase }

function Projectile:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 75
end

function Projectile:config(id, x, y, velocity)
	EntityBase.config(self, id, x, y)

	self.velocity = velocity
end

function Projectile:update(dt)
	EntityBase.update(self, dt)

	self.pos = self.pos + self.velocity * dt * self.speed
end