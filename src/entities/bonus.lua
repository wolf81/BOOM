Bonus = Entity:extend()

function Bonus:new(data)
	Bonus.super.new(self, data)

	self._applied = false
end

function Bonus:setApplied()
	self._applied = true
end

function Bonus:isApplied()
	return self._applied
end

function Bonus:update(dt)
	-- body
end