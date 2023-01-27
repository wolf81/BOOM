--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor = math.floor

Player = Class { __includes = { EntityBase, Movable } }

function Player:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.speed = def.speed

	self.control = PlayerControl(self)
	self.z_index = 9

	self.animations = ParseAnimations(def.animations)
	self.animation = self.animations['idle']

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')	
end

function Player:update(dt)
	EntityBase.update(self, dt)

	self.control:update(dt)
	self.state_machine:update(dt)
	self.animation:update(dt)	
end

function Player:draw()
	love.graphics.draw(self.image, self.quads[self.animation:getCurrentFrame()], math_floor(self.pos.x), math_floor(self.pos.y))
end

function Player:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Player:idle()
	self.direction = Direction.NONE
	self.state_machine:change('idle')
end

function Player:isIdling()
	return getmetatable(self.state_machine.current) == Idle
end
