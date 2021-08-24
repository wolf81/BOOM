Creature = Entity:extend()

function Creature:new(data)
	Creature.super.new(self, data)

	self._direction = nil
end

function Creature:move(direction)
	if self._direction == direction then return end

	self._direction = direction

	self._stateMachine:change('move', self)
end

function Creature:direction()
	return self._direction
end