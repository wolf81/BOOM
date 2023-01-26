local mfloor = math.floor

Player = Class { __includes = EntityBase }

function Player:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.speed = def.speed

	self.control = Control(self)
	self.direction = Direction.none

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
	love.graphics.draw(self.image, self.quads[self.animation:getCurrentFrame()], mfloor(self.pos.x), mfloor(self.pos.y))
end

function Player:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Player:move(direction)
	self.direction = direction

	local state_name = direction == Direction.none and 'idle' or 'move'
	self.state_machine:change(state_name, direction)
end

function Player:idle()
	self.state_machine:change('idle')
end

function Player:isMoving()
	return getmetatable(self.state_machine.current) == Move
end

function Player:isIdling()
	return getmetatable(self.state_machine.current) == Idle
end
