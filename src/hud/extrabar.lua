ExtraBar = Object:extend()

function ExtraBar:new()
	self._extraIcons = love.graphics.newImage('gfx/EXTRA Icons.png')
	self._quads = generateQuads(self._extraIcons, 15, 15)
end

function ExtraBar:update(dt)
	-- body
end

function ExtraBar:draw()
	for i = 0, 4 do
		love.graphics.draw(self._extraIcons, self._quads[1], i * 13, 0)
	end
end