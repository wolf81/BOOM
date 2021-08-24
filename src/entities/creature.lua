Creature = Entity:extend()

function Creature:new(data)
	Creature.super.new(self, data)

	self._speed = data.speed or 1.0
end

function Creature:isMoving()
	return self._stateMachine:currentStateName() == 'move'
end

function Creature:move(direction)
	if self:isMoving() then return end

	if direction ~= nil then
		print('dir', direction)
		self._stateMachine:change('move', {self, direction })
	end
end

function Creature:speed()
	return self._speed
end