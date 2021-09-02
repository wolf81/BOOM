Destroy = State:extend()

function Destroy:enter(params)	
	-- add a default destroy animation if none is defined
	if params.stateInfo.anim == nil then
		params.stateInfo.anim = {
			duration = -1,
		}
	end

	Destroy.super.enter(self, params)
end

function Destroy:update(dt)
	Destroy.super.update(self, dt)

	if self:isFinished() then
		self.entity:remove()
	end
end
