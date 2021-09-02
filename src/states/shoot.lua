Shoot = State:extend()

function Shoot:enter(params)
	local entity = params.entity
	
	local direction = entity:direction()	
	if direction == Direction.UP then
		params.stateInfo = params.stateInfo.up
	elseif direction == Direction.DOWN then
		params.stateInfo = params.stateInfo.down
	elseif direction == Direction.LEFT then
		params.stateInfo = params.stateInfo.left
	elseif direction == Direction.RIGHT then
		params.stateInfo = params.stateInfo.right
	end

	Shoot.super.enter(self, params)
end

function Shoot:update(dt)
	Shoot.super.update(self, dt)

	if self:isFinished() then
		self.entity:idle()
	end
end