--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor = math.floor

EntityBase = Class {}

function EntityBase:init(def, x, y)
	assert(def ~= nil, 'definition is required')
	assert(def.name ~= nil, 'name is required')
	assert(def.animations ~= nil, 'definition should contain animations table')
	assert(def.animations['idle'] ~= nil, 'animation table should contain idle animation')

	self.name = def.name
	self.description = def.description or ''
	self.z_index = def.z_index or 0
	self.id = nil -- id will be assigned when created using EntityFactory
	
	self.pos = vector(x or 0, y or 0)
	self.size = vector(ParseSpriteSize(def.size))

	self.image = ImageCache.load(def.texture)
	self.quads = GenerateQuads(self.image, self.size.x, self.size.y)
	self.animations = ParseAnimations(def.animations)
	self.animation = self.animations['idle']
end

function EntityBase:getFrame()
	return self.pos.x, self.pos.y, self.size.x, self.size.y
end

function EntityBase:update(dt)
	self.animation:update(dt)	
end

function EntityBase:draw()
	love.graphics.draw(self.image, self.quads[self.animation:getCurrentFrame()], math_floor(self.pos.x), math_floor(self.pos.y))
end

-- the skip list uses the less-than operator to determine drawing order based on z_index
function EntityBase:__lt(other)
	return self.z_index < other.z_index
end
