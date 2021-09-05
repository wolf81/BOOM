StatusEffect = Object:extend()

function StatusEffect:new(maxAmount)
	self._amount = 0
	self._maxAmount = maxAmount or 1
	self._duration = -1
end

function StatusEffect:increment()
	self._amount = math.min(self._amount + 1, self._maxAmount)
end

function StatusEffect:amount()
	return self._amount
end

function StatusEffect:setDuration(duration)
	self._duration = duration
	self._amount = 1
end

function StatusEffect:active()
	return self._amount > 0
end

function StatusEffect:update(dt)
	if self._duration == -1 then return end

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then self._amount = 0 end
end

function StatusEffect:draw()
	-- body
end