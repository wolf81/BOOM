Animation = Object:extend()

function Animation:new(entity)
	self._entity = entity

	self._texture = love.graphics.newImage(entity:texture())
	local tw, th = self._texture:getDimensions()

	local quads = {}
	for y = 0, (th - 32), 32 do
		for x = 0, (tw - 32), 32 do
			local quad = love.graphics.newQuad(x, y, 32, 32, self._texture)
			quads[#quads + 1] = quad
		end
	end
	self._quads = quads

	self._frameIndex = 1
end

function Animation:update(dt)
	-- body
end

function Animation:draw(offset)
	local pos = offset + self._entity:position():permul(TileSize)
	local quad = self._quads[self._frameIndex]
	love.graphics.draw(self._texture, quad, pos.x, pos.y)
end