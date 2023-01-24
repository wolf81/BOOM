Move = Class { __includes = StateBase }

function Move:enter(direction)
	StateBase.enter(self, entity)

	-- TODO: instead of using anim8, just store a list of quads and use simple Animation implementation
	if direction == 'up' then
		self.anim = anim8.newAnimation(self.entity.anim_grid('9-16', 1), 0.1)
	elseif direction == 'down' then
		self.anim = anim8.newAnimation(self.entity.anim_grid('1-8', 1), 0.1)
	elseif direction == 'left' then
		self.anim = anim8.newAnimation(self.entity.anim_grid('25-32', 1), 0.1)
	elseif direction == 'right' then
		self.anim = anim8.newAnimation(self.entity.anim_grid('17-24', 1), 0.1)
	else 
		error('invalid direction: ' .. direction)
	end

end

function Move:update(dt)
	self.anim:update(dt)
end

function Move:draw()
	self.anim:draw(self.entity.image, self.entity.x, self.entity.y)
end
