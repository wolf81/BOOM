--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

EntityBase = Class {}

function EntityBase:init(def, x, y)
	assert(def ~= nil, 'definition is required')
	assert(x ~= nil, 'x position is required')
	assert(y ~= nil, 'y position is required')
	assert(def.name ~= nil, 'name is required')

	self.name = def.name
	self.description = def.description or ''
	
	self.pos = vector(x, y)

	self.image = ImageCache.load(def.texture)
	self.z_index = 0

	local sprite_w, sprite_h = ParseSpriteSize(def.size)
	self.quads = GenerateQuads(self.image, sprite_w, sprite_h)
end

function EntityBase:update(dt)
	-- body
end

function EntityBase:draw()
	love.graphics.draw(self.image, self.quads[1], self.pos.x, self.pos.y)
end

function EntityBase:__lt(other)
	return self.z_index < other.z_index
end
