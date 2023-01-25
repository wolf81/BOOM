Move = Class { __includes = StateBase }

function Move:enter(direction)
	StateBase.enter(self)

	self.entity.anim = self.entity.animations['move-' .. GetDirectionName(direction)]

	self.entity.velocity = direction
end
