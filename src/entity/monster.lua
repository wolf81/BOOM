local math_floor = math.floor

Monster = Class { __includes = { EntityBase, Movable } }

function Monster:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.speed = def.speed or 1.0
	self.z_index = 5

	self.animations = ParseAnimations(def.animations)
	self.animation = self.animations['idle']

	self.control = CpuControl(self)

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')		
end

function Monster:update(dt)
	EntityBase.update(self, dt)

	self.control:update(dt)
	self.state_machine:update(dt)
	self.animation:update(dt)	
end

function Monster:draw()
	love.graphics.draw(self.image, self.quads[self.animation:getCurrentFrame()], math_floor(self.pos.x), math_floor(self.pos.y))
end

function Monster:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Monster:idle()
	self.direction = Direction.NONE
	self.state_machine:change('idle')
end

function Monster:isIdling()
	return getmetatable(self.state_machine.current) == Idle
end
