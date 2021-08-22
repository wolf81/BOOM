Block = Entity:extend()

function Block:new(x, y, breakable)
	Block.super.new(self, x, y)

	self._breakable = breakable
end

function Block:isBreakable()
	return self._breakable
end