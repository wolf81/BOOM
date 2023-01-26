Idle = Class { __includes = StateBase }

function Idle:enter()
	StateBase.enter(self)	

	self.entity.animation = self.entity.animations['idle']
end
