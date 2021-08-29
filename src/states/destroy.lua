Destroy = State:extend()

function Destroy:update(dt)
	Destroy.super.update(self, dt)

	if self:isFinished() then
		self.entity:remove()
	end
end
