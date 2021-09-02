Shoot = State:extend()

local function getAnimationInfo(direction, stateInfo)
	if direction == Direction.UP then return stateInfo.up.anim
	elseif direction == Direction.DOWN then return stateInfo.down.anim
	elseif direction == Direction.RIGHT then return stateInfo.right.anim
	elseif direction == Direction.LEFT then return stateInfo.left.anim
	end
end

function Shoot:enter(params)
	params.stateInfo.anim = getAnimationInfo(params.entity:direction(), params.stateInfo)

	Shoot.super.enter(self, params)
end

function Shoot:update(dt)
	Shoot.super.update(self, dt)

	if self:isFinished() then
		self.entity:idle()
	end
end