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

--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]

ShieldStatusEffect = StatusEffect:extend()

function ShieldStatusEffect:new(maxAmount)
	ShieldStatusEffect.super.new(self, maxAmount)

	self._texture = love.graphics.newImage("gfx/Shield.png")
	self._quads = generateQuads(self._texture, 32, 32)
end

function ShieldStatusEffect:setPlayer(player)
	self._player = player
end

function ShieldStatusEffect:draw()
	if self._amount == 0 then return end
	
	local quad = self._quads[1]

	local direction = self._player:direction()
	if direction == Direction.LEFT then
		quad = self._quads[3]
	elseif direction == Direction.RIGHT then
		quad = self._quads[2]
	end

	local pos = self._player:position()

	love.graphics.setColor(1, 1, 1, 0.4)
	love.graphics.draw(self._texture, quad, pos.x, pos.y)
	love.graphics.setColor(1, 1, 1, 1)
end

