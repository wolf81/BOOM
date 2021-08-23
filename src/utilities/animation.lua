Animation = Object:extend()

function Animation:new(entity)
	self._entity = entity

	local texture, quads = QuadCache:get(entity)
	self._texture = texture
	self._quads = quads
	self._frameIndex = 1
end

function Animation:update(dt)
	-- body
end

function Animation:draw()
	local pos = self._entity:position()
	local quad = self._quads[self._frameIndex]
	love.graphics.draw(self._texture, quad, pos.x, pos.y)
end