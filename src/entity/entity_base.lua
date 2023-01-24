EntityBase = Class {}

function EntityBase:init(def)
	self.x = def.x
	self.y = def.y

	self.texture = ImageCache.load(def.texture)
	self.quad = love.graphics.newQuad(0, 0, TILE_W, TILE_H, self.texture)
end

function EntityBase:update(dt)
	-- body
end

function EntityBase:draw()
	love.graphics.draw(self.texture, self.quad, self.x, self.y)
end
