--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

-- TODO: I think it's a good idea to just add a StateMachine by default to each entity
--
-- Since DestroyState already removes entities from level, we can then use DestroyState
-- as initial state for entities like Flash
-- 
-- Also, based on animation keys defined in entity definition we can dynamically include
-- mixins for the appropriate states

local math_floor, lume_round = math.floor, lume.round

EntityBase = Class {}

local function addIdleAnimationIfNeeded(animations)
	if animations['idle'] then return end
	animations['idle'] = Animation({
		frames = { 1 },
		interval = 0.1,
	}) 
end

function EntityBase:init(def)
	assert(def ~= nil, 'definition is required')
	assert(def.name ~= nil, 'name is required')
	assert(def.animations ~= nil, 'definition should contain animations table')

	self.name = def.name
	self.description = def.description or ''
	self.z_index = def.z_index or 0
	self.id = nil -- assigned by EntityFactory
	self.level = nil -- assigned by Level when added to Level
	
	self.pos = vector(0, 0)
	self.size = vector(ParseSpriteSize(def.size))

	self.image = ImageCache.load(def.texture)
	self.quads = GenerateQuads(self.image, self.size.x, self.size.y)
	self.animations = ParseAnimations(def.animations)
	addIdleAnimationIfNeeded(self.animations)
	self.animation = self.animations['idle']	

	self.category_flags = Category.NONE
	self.collision_flags = Category.NONE
end

function EntityBase:config(id, x, y)
	self.id = id
	self.pos = vector(x, y)
end

function EntityBase:gridPosition()
	return vector(lume_round(self.pos.x / TILE_W), lume_round(self.pos.y / TILE_H))	
end

function EntityBase:animate(name)
	self.animation = self.animations[name]
	assert(self.animation ~= nil, 'no animation defined named: ' .. name)
end

function EntityBase:getFrame()
	return self.pos.x, self.pos.y, self.size.x, self.size.y
end

function EntityBase:update(dt)
	self.animation:update(dt)	
end

function EntityBase:is(T)
	return getmetatable(self) == T
end

function EntityBase:draw()
	love.graphics.draw(self.image, self.quads[self.animation:getCurrentFrame()], math_floor(self.pos.x), math_floor(self.pos.y))
end

-- the skip list uses the less-than operator to determine drawing order based on z_index
function EntityBase:__lt(other)
	if self.z_index < other.z_index then return true 
	elseif self.z_index == other.z_index and self.id < other.id then return true
	else return false end
end
