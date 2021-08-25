Bomb = Entity:extend()

function Bomb:fuse()
	self._stateMachine:change('fuse', self)
end

function Bomb:idle()
	self:fuse()
end