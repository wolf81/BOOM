Coin = Class { __includes = EntityBase }

function Coin:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.animations = ParseAnimations(def.animations)

	self.anim = self.animations['idle']

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
	}
	self.state_machine:change('idle')	
end

function Coin:update(dt)
	EntityBase.update(self, dt)

	self.state_machine:update(dt)
	self.anim:update(dt)	
end

function Coin:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Coin:draw()
	love.graphics.draw(self.image, self.quads[self.anim:getCurrentFrame()], self.x, self.y)
end
