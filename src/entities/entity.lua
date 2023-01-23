Entity = Class {}

function Entity:init(def)
	self.x = def.x
	self.y = def.y

	self.texture = love.graphics.newImage(def.texture)
	self.quad = love.graphics.newQuad(0, 0, TILE_W, TILE_H, self.texture)
end

function Entity:update(dt)
	-- body
end

function Entity:draw()
	love.graphics.draw(self.texture, self.quad, self.x, self.y)
end
