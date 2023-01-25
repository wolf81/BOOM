Idle = Class { __includes = StateBase }

function Idle:enter()
	StateBase.enter(self)	

	self.entity.anim = self.entity.animations['idle']
end
