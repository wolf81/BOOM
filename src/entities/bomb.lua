Bomb = Entity:extend()

function Bomb:fuse()
	self._stateMachine:change('fuse', self)
end

function Bomb:size()
	return self._data.size or 0
end