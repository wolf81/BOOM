Creature = Entity:extend()

function Creature:new(data)
	Creature.super.new(self, data)

	self._speed = data.speed or 1.0
	self._direction = Direction.NONE
	self._control = {
		update = function() end
	}	
end

function Creature:update(dt)
	Creature.super.update(self, dt)
	
	self._control:update(dt)
end

function Creature:setControl(control)
	self._control = control
end

function Creature:isMoving()
	return self._stateMachine:currentStateName() == 'move'
end

function Creature:move(direction)
	if self:isMoving() then 
		if direction == Direction.opposite(self._direction) then
			self._direction = direction
			self._stateMachine:change('move', self)
		end
	else
		local toPos = self:gridPosition() + direction
		if self:level():isBlocked(toPos) then
			return
		end

		if direction ~= Direction.NONE then
			self._direction = direction
			self._stateMachine:change('move', self)
		end
	end
end

function Creature:idle()
	self._direction = Direction.NONE	
	Creature.super.idle(self)
end

function Creature:speed()
	return self._speed
end

function Creature:direction()
	return self._direction
end