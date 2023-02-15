local math_random, lume_round = math.random, lume.round

AlienEggCrack = Class { __includes = Projectile }

function AlienEggCrack:config(id, x, y, direction)
	Projectile.config(self, id, x, y, direction)

	self.getFrame = self.defaultFrameFunc

	self.pos = vector(x, y)
	self.offset = vector.zero
end

function AlienEggCrack:destroy()
	if not self:isDestroyed() then
		local x, y = self.pos.x + TILE_W_2, self.pos.y + TILE_H_2
		local grid_pos = vector(lume_round(x / TILE_W), lume_round(y / TILE_H))
		local monster_keys = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J' }
		local monster_idx = math_random(#monster_keys)
		local soldier = EntityFactory.create(monster_keys[monster_idx], grid_pos.x * TILE_W, grid_pos.y * TILE_H)
		self.level:addEntity(soldier)
	end

	Projectile.destroy(self)
end
