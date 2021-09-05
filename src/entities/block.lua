Block = Entity:extend()

function Block:new(data)
	Block.super.new(self, data)

	self._destroyDelay = -1
	self._breakable = data.breakable == true or false
end

function Block:isBreakable()
	return self._breakable
end

function Block:destroyAfter(delay)
	self._destroyDelay = delay
end

function Block:update(dt)
	Block.super.update(self, dt)

	if self._destroyDelay < 0 then return end

	self._destroyDelay = math.max(self._destroyDelay - dt, 0)
	if self._destroyDelay == 0 then
		self:destroy()
	end
end

function Block:destroy()
	if not self._breakable then return false end

	if Block.super.destroy(self) then
		self:level():trySpawnBonus(self:gridPosition())
		return true
	end

	return false
end