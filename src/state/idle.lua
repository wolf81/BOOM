Idle = Class { __includes = StateBase }

function Idle:enter()
	StateBase.enter(self, entity)	
	self.anim = anim8.newAnimation(self.entity.anim_grid('1-1', 1), 0.1)
end

function Idle:update(dt)
	self.anim:update(dt)
end

function Idle:draw()
	self.anim:draw(self.entity.image, self.entity.x, self.entity.y)
end
