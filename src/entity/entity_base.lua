local anim8 = require 'lib.anim8.anim8'

EntityBase = Class {}

function EntityBase:init(def)
	self.x = def.x
	self.y = def.y

	self.image = ImageCache.load(def.texture)

	local grid = anim8.newGrid(TILE_W, TILE_H, self.image:getWidth(), self.image:getHeight())
	self.animation = anim8.newAnimation(grid('1-1', 1), 0.1)
end

function EntityBase:update(dt)
	self.animation:update(dt)
end

function EntityBase:draw()
	self.animation:draw(self.image, self.x, self.y)
end
