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
	self.z_index = def.z_index or 0
	
	self.pos = vector(x, y)
	self.size = vector(ParseSpriteSize(def.size))

	self.image = ImageCache.load(def.texture)
	self.quads = GenerateQuads(self.image, self.size.x, self.size.y)
end

function EntityBase:getFrame()
	return self.pos.x, self.pos.y, self.size.x, self.size.y
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
