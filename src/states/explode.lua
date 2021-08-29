Explode = State:extend()

function Explode:update(dt)
	Explode.super.update(self, dt)

	if self:isFinished() then
		self.entity:destroy()
	end
end
