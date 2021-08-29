Detonate = State:extend()

function Detonate:update(dt)
	Detonate.super.update(self, dt)

	if self:isFinished() then
		self.entity:destroy()
	end
end