local mfloor = math.floor

Player = Class { __includes = EntityBase }

function Player:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.velocity = vector(0, 0)
	self.speed = def.speed

	self.control = Control(self)

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

	self.pos = self.pos + self.velocity * dt * self.speed

	self.control:update(dt)
	self.state_machine:update(dt)
	self.animation:update(dt)	
end

function Player:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Player:draw()
	love.graphics.draw(self.image, self.quads[self.animation:getCurrentFrame()], mfloor(self.pos.x), mfloor(self.pos.y))
end
