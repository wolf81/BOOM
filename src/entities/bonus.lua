Bonus = Entity:extend()

local DESPAWN_DURATION = 10.0
local FLICKER_DURATION = 3.0

function Bonus:new(data)
	Bonus.super.new(self, data)

	self._applied = false

	self._duration = DESPAWN_DURATION
end

function Bonus:setApplied()
	self._applied = true
end

function Bonus:isApplied()
	return self._applied
end

function Bonus:update(dt)
	Bonus.super.update(self, dt)

	self._duration = math.max(self._duration - dt, 0)
	if self._duration == 0 then
		self:destroy()
	end
end

function Bonus:draw()
	local alpha = 1.0

	if self._duration < FLICKER_DURATION then
		local a = math.floor(self._duration * 25)
		alpha = a % 2 == 0 and 1.0 or 0.0
	end

	love.graphics.setColor(1, 1, 1, alpha)
	Bonus.super.draw(self)
	love.graphics.setColor(1, 1, 1, 1)
end