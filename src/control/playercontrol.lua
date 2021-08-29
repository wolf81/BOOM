PlayerControl = Object:extend()

function PlayerControl:new(level, player, input)
	self._level = level
	self._player = player
	self._input = input
end

function PlayerControl:update(dt)
	self._input:update()

	if self._input:down('up') then self._player:move(Direction.UP)
	elseif self._input:down('down') then self._player:move(Direction.DOWN)
	elseif self._input:down('left') then self._player:move(Direction.LEFT)
	elseif self._input:down('right') then self._player:move(Direction.RIGHT)
	else self._player:move(Direction.NONE) end

	if self._input:pressed('action') then self._player:dropBomb() end
end