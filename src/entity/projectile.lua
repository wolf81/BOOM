Projectile = Class { __includes = EntityBase }

function Projectile:init(def)
	EntityBase.init(self, def)

	self.speed = def.speed or 75
	self.size = def.size or 1

	self.category_flags = Category.PROJECTILE
	self.collision_flags = bit.bor(Category.BREAKABLE_BLOCK, Category.FIXED_BLOCK, Category.PLAYER)
end

function Projectile:config(id, x, y, velocity)
	EntityBase.config(self, id, x, y)

	self.offset = vector.zero

	if velocity == Direction.DOWN then
		self.offset = vector((TILE_W - self.size) / 2, TILE_H)
	elseif velocity == Direction.UP then
		self.offset = vector((TILE_W - self.size) / 2, 0)		
	elseif velocity == Direction.LEFT then
		self.offset = vector(-self.size, TILE_H / 2)
	elseif velocity == Direction.RIGHT then
		self.offset = vector(TILE_W, TILE_H / 2)
	end

	self.pos = self.pos + self.offset

	self.velocity = velocity
end

function Projectile:getFrame()
	return self.pos.x, self.pos.y, self.size, self.size
end

function Projectile:destroy()
	if self:isDestroyed() then return end

	EntityBase.destroy(self)

	self.pos = self.pos - self.offset
	self.velocity = vector.zero
end

function Projectile:update(dt)
	EntityBase.update(self, dt)

	self.pos = self.pos + self.velocity * dt * self.speed
end