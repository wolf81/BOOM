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
	local lw, lh = (Map.WIDTH + 2) * TileSize.x, (Map.HEIGHT + 2) * TileSize.y
	self._offset = vector((sw - lw) / 2, (sh - lh) / 2)

	self._level = Level(levelIndex)
	for _, player in ipairs(self._level:players()) do
		if player:index() == 1 then
			local control = PlayerControl(level, player, p1Input)
			player:setControl(control)
		end
	end
end

function Game:update(dt)
	self._level:update(dt)
end

function Game:draw()
	love.graphics.push()
	love.graphics.translate(self._offset.x, self._offset.y)

	self._level:draw()

	love.graphics.pop()
end