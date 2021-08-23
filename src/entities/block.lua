Block = Entity:extend()

function Block:new(breakable)
	Block.super.new(self)

	self._breakable = breakable
end

function Block:isBreakable()
	return self._breakable
end