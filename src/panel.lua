Panel = Object:extend()

function Panel:new()
	self._background = love.graphics.newImage('gfx/Panel.png')
end

function Panel:getDimensions()
	return self._background:getDimensions()
end

function Panel:update(dt)
	-- body
end

function Panel:draw()
	love.graphics.draw(self._background)
end