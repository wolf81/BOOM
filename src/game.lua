Game = Object:extend()

local p1Input = baton.new({
	controls = {
		left = {'key:a', 'axis:leftx-', 'button:dpleft'},
		right = {'key:d', 'axis:leftx+', 'button:dpright'},
		up = {'key:w', 'axis:lefty-', 'button:dpup'},
		down = {'key:s', 'axis:lefty+', 'button:dpdown'},
		action = {'key:space', 'button:a'},
	},
	pairs = {},
	joystick = love.joystick.getJoysticks()[1]
})

local function playMusic()
	AudioPlayer.setMusicVolume(0.2)
	AudioPlayer.playMusic('BOOM Music 1')
end

function Game:new(levelIndex)
	playMusic()

	local sw, sh = love.graphics.getDimensions()

	self._panel = Panel()
	local pWidth, pHeight = self._panel:getDimensions()

	self._level = Level(levelIndex)
	local lWidth, lHeight = self._level:getDimensions()

	local width = pWidth + lWidth
	local px = (sw - pWidth - lWidth) / 2
	local py = (sh - pHeight) / 2
	self._pOffset = vector(px, py)

	local lx = (sw - lWidth) / 2 + pWidth / 2
	local ly = (sh - lHeight) / 2
	self._lOffset = vector(lx, ly)

	for _, player in ipairs(self._level:players()) do
		if player:index() == 1 then
			local control = PlayerControl(level, player, p1Input)
			player:setControl(control)
		end
	end
end

function Game:update(dt)
	self._level:update(dt)
	self._panel:update(self._level:time(), self._level:players())
end

function Game:draw()
	love.graphics.push()
	love.graphics.translate(self._pOffset.x, self._pOffset.y)
	self._panel:draw()
	love.graphics.pop()

	love.graphics.push()
	love.graphics.translate(self._lOffset.x, self._lOffset.y)
	self._level:draw()
	love.graphics.pop()
end