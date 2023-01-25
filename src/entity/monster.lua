Monster = Class { __includes = EntityBase }

function Monster:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.animations = ParseAnimations(def.animations)

	self.anim = self.animations['idle']

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
	}
	self.state_machine:change('idle')		
end

function Monster:update(dt)
	EntityBase.update(self, dt)

	self.state_machine:update(dt)
	self.anim:update(dt)	
end

function Monster:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Monster:draw()
	love.graphics.draw(self.image, self.quads[self.anim:getCurrentFrame()], self.pos.x, self.pos.y)
end
