EntityBase = Class {}

function EntityBase:init(def, x, y)
	self.pos = vector(x, y)

	self.image = ImageCache.load(def.texture)

	local sprite_w, sprite_h = ParseSpriteSize(def.size)
	self.quads = GenerateQuads(self.image, sprite_w, sprite_h)
end

function EntityBase:update(dt)
	-- body
end

function EntityBase:draw()
	love.graphics.draw(self.image, self.quads[1], self.pos.x, self.pos.y)
end
