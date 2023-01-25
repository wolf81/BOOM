EntityBase = Class {}

function EntityBase:init(def)
	self.x = def.x
	self.y = def.y

	self.image = ImageCache.load(def.texture)
	self.quads = GenerateQuads(self.image, TILE_W, TILE_H)
end

function EntityBase:update(dt)
	-- body
end

function EntityBase:draw()
	love.graphics.draw(self.image, self.quads[1], self.x, self.y)
end
