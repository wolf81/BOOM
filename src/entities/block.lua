Block = Entity:extend()

function Block:new(data)
	Block.super.new(self, data)

	self._breakable = data.breakable == true or false
end

function Block:isBreakable()
	return self._breakable
end