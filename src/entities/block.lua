Block = Entity:extend()

function Block:new(data)
	Block.super.new(self, data)

	self._breakable = data.breakable == true or false
end

function Block:isBreakable()
	return self._breakable
end

function Block:destroy()
	if not self._breakable then return false end

	if Block.super.destroy(self) then
		print('try spawn bonus')
		return true
	end

	return false
end