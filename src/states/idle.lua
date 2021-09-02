Idle = State:extend()

function Idle:enter(params)
	-- add a default idle animation if none is defined
	if params.stateInfo.anim == nil then
		params.stateInfo.anim = {
			['frames'] = {1, 1},
			['duration'] = 0.0,
		}
	end

	Idle.super.enter(self, params)	
end