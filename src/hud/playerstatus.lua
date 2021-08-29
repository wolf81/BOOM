PlayerStatus = Object:extend()

local font = {
	SCORE = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 16),
	POINTS = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 14),
}

function PlayerStatus:new(playerIndex)
	self._playerIndex = playerIndex

	local path = (playerIndex == 1 and 
		'gfx/Player 1 Head.png' or 
		'gfx/Player 2 Head.png')

	self._head = love.graphics.newImage(path)
end

function PlayerStatus:update(dt)
	-- body
end

function PlayerStatus:draw()
	love.graphics.draw(self._head, 14, 60)

	love.graphics.setFont(font.SCORE)
	love.graphics.print('score', 14, 170)

	love.graphics.setFont(font.POINTS)
	love.graphics.print('000000', 12, 192)
end