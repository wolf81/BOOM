Player = Class { __includes = EntityBase }

function Player:init(def, x, y)
	EntityBase.init(self, def, x, y)

	self.animations = ParseAnimations(def.animations)

	self.anim = self.animations['idle']

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')	
end

function Player:update(dt)
	EntityBase.update(self, dt)

	if love.keyboard.isDown('up') then
		self:changeState('move', 'up')
	elseif love.keyboard.isDown('down') then
		self:changeState('move', 'down')
	elseif love.keyboard.isDown('left') then
		self:changeState('move', 'left')
	elseif love.keyboard.isDown('right') then
		self:changeState('move', 'right')
	else
		self:changeState('idle') 
	end

	self.state_machine:update(dt)
	self.anim:update(dt)	
end

function Player:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function Player:draw()
	love.graphics.draw(self.image, self.quads[self.anim:getCurrentFrame()], self.x, self.y)
end
