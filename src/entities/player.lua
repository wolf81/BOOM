Player = Creature:extend()

local input = baton.new {
  controls = {
    left = {'key:left', 'key:a', 'axis:leftx-', 'button:dpleft'},
    right = {'key:right', 'key:d', 'axis:leftx+', 'button:dpright'},
    up = {'key:up', 'key:w', 'axis:lefty-', 'button:dpup'},
    down = {'key:down', 'key:s', 'axis:lefty+', 'button:dpdown'},
    action = {'key:x', 'button:a'},
  },
  pairs = {
    --move = {'left', 'right', 'up', 'down'}
  },
  joystick = love.joystick.getJoysticks()[1],
}

function Player:new(data)
	print('init player')

	Player.super.new(self, data)

	self._index = data.id == "X" and 1 or 2
	print(self._index)
end

function Player:index()
	return self._index
end

function Player:update(dt)
	Player.super.update(self, dt)

	if not (self._index == 1) then return end

	input:update()

	if input:down('up') then self:move(Direction.UP)
	elseif input:down('down') then self:move(Direction.DOWN)
	elseif input:down('left') then self:move(Direction.LEFT)
	elseif input:down('right') then self:move(Direction.RIGHT)
	else self:idle() end
end