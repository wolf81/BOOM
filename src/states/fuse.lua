Fuse = State:extend()

function Fuse:update(dt)
	Fuse.super.update(self, dt)

	if self:isFinished() then
		self.entity:detonate()
	end
end
