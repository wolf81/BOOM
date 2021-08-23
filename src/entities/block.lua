Block = Entity:extend()

function Block:new(data)
	Block.super.new(self, data)

	self._breakable = false
end

function Block:setBreakable(breakable)
	self._breakable = breakable or false
end

function Block:isBreakable()
	return self._breakable
end