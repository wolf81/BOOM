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

local function configureStateMachineIfNeeded(self)
	local states = {}

	local use_dummy = true

	if self.animations['move-down'] ~= nil then
		states['move'] = function() return Move(self) end
		use_dummy = false

		self.direction = nil
	end

	if self.animations['destroy'] ~= nil then
		states['destroy'] = function() return Destroy(self) end
		use_dummy = false
	end

	if self.animations['attack-down'] ~= nil then
		states['attack'] = function() return Attack(self) end
		use_dummy = false
	end

	if self.animations['propel-down'] ~= nil then
		states['propel'] = function() return Propel(self) end
		use_dummy = false
	end 

	if self.animations['hit'] ~= nil then
		states['hit'] = function() return Hit(self) end
		use_dummy = false
	end

	if use_dummy then
		self.state_machine = StateMachine()
	else
		states['idle'] = function() return Idle(self) end

		self.state_machine = StateMachine(states)
		self.state_machine:change('idle')		
	end
end

function EntityBase:init(def)
	assert(def ~= nil, 'definition is required')
	assert(def.name ~= nil, 'name is required')
	assert(def.animations ~= nil, 'definition should contain animations table')

	self.name = def.name
	self.description = def.description or ''
	self.id = nil -- assigned by EntityFactory
	self.level = nil -- assigned by Level when added to Level
	self.value = def.value
	
	self.pos = vector(0, 0)
	self.size = vector(ParseSpriteSize(def.sprite_size))

	self.image = ImageCache.load(def.texture)
	self.quads = GenerateQuads(self.image, self.size.x, self.size.y)
	self.animations = ParseAnimations(def.animations)
	addIdleAnimationIfNeeded(self.animations)
	self.animation = self.animations['idle']

	self.sounds = def.sounds or {}

	self.category_flags = Category.NONE
	self.collision_flags = Category.NONE
end

function EntityBase:config(id, x, y)
	self.id = id
	self.pos = vector(x, y)

	configureStateMachineIfNeeded(self)
end

function EntityBase:gridPosition()
	return vector(lume_round(self.pos.x / TILE_W), lume_round(self.pos.y / TILE_H))	
end

function EntityBase:animate(name)
	self.animation = self.animations[name]
	assert(self.animation ~= nil, 'no animation defined named: ' .. name)
end

function EntityBase:playSound(name)
	local sound = self.sounds[name]
	if sound then AudioPlayer.playSound(sound) end	
end

function EntityBase:getFrame()
	return self.pos.x, self.pos.y, self.size.x, self.size.y
end

function EntityBase:update(dt)
	self.animation:update(dt)

	self.state_machine:update(dt)
end

function EntityBase:is(T)
	return getmetatable(self) == T
end

function EntityBase:draw()
	love.graphics.draw(self.image, self.quads[self.animation:getCurrentFrame()], math_floor(self.pos.x), math_floor(self.pos.y))
end

-- spawn

function EntityBase:spawn()
	self:playSound('spawn')
end

-- idle

function EntityBase:idle()
	self.state_machine:change('idle')
end

function EntityBase:isIdling()
	return getmetatable(self.state_machine.current) == Idle
end

-- move

function EntityBase:move(direction)
	self.direction = direction

	local state_name = direction == nil and 'idle' or 'move'
	self.state_machine:change(state_name, direction)
end

function EntityBase:isMoving()
	return getmetatable(self.state_machine.current) == Move
end

-- destroy

function EntityBase:destroy()
	if getmetatable(self.state_machine.current) == Destroy then return end

	if self.value then
		local entity_key = 'points1k'

		if self.value == 5000 then
			entity_key = 'points5k'
		elseif self.value == 100000 then
			entity_key = 'points100k'
		end

		local mid_x, mid_y = self.pos.x + self.size.x / 2, self.pos.y + self.size.y / 2
		self.level:addEntity(EntityFactory.create(entity_key, mid_x, mid_y, self.value))		
	end
	
	self.state_machine:change('destroy')
end

function EntityBase:isDestroyed()
	return getmetatable(self.state_machine.current) == Destroy
end

-- attack

function EntityBase:attack()	
	if getmetatable(self.state_machine.current) == Attack then return end

	self.state_machine:change('attack')
end

function EntityBase:isAttacking()
	return getmetatable(self.state_machine.current) == Attack
end

-- hit

function EntityBase:hit()
	if getmetatable(self.state_machine.current) == Hit then return end

	self.state_machine:change('hit')
end

function EntityBase:isHit()
	return getmetatable(self.state_machine.current) == Hit
end
