Panel = Object:extend()

local font = {
	SCORE = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 12),
	POINTS = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 14),
	TIME = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 12),
}

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

	love.graphics.setFont(font)
	love.graphics.print('02', 18, 234)
	love.graphics.print(':', 44, 234)
	love.graphics.print('58', 50, 234)

	love.graphics.print('score', 16, 176)
	love.graphics.print('000000', 10, 196)

end