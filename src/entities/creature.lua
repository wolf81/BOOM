Creature = Entity:extend()

function Creature:new(data)
	Creature.super.new(self, data)

	self._direction = nil
	self._speed = data.speed or 1.0
end

function Creature:move(direction)
	if self._direction == direction then return end

	self._direction = direction

	--print(direction)

	if direction ~= Direction.NONE then
		self._stateMachine:change('move', self)
	else
		self:idle()
	end
end

function Creature:speed()
	return self._speed
end

function Creature:direction()
	return self._direction
end
