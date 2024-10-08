Panel = Object:extend()

local font = {
	TIME = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 12),
}

function Panel:new()
	self._background = love.graphics.newImage('gfx/Panel.png')

	self._playerStatus1 = PlayerStatus(1)
	self._playerStatus2 = PlayerStatus(2)

	self._seconds = 0
	self._minutes = 0

	self._lives = 3
end

function Panel:getDimensions()
	return self._background:getDimensions()
end

function Panel:update(time, players)
	self._seconds = time % 60
	self._minutes = math.floor(time / 60)

	for _, player in ipairs(players) do
		if player:index() == 1 then
			self._playerStatus1:updatePlayerStatus(player)
		else
			self._playerStatus2:updatePlayerStatus(player)
		end
	end
end

function Panel:draw()
	love.graphics.draw(self._background)

	love.graphics.setFont(font.TIME)
	love.graphics.print(string.format('%02d', self._minutes), 22, 229)
	love.graphics.print(':', 45, 229)
	love.graphics.print(string.format('%02d', self._seconds), 52, 229)

	self._playerStatus1:draw()

	love.graphics.push()
	love.graphics.translate(0, 206, 0)
	self._playerStatus2:draw()
	love.graphics.pop()
end