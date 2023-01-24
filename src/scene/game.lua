Game = Class { __includes = SceneBase }

function Game:init()
	SceneBase.init(self)
end

function Game:enter(previous, level)
	self.level = level
end

function Game:update(dt)
	self.level:update(dt)
end

function Game:draw()
	self.level:draw()
end

function Game:keyreleased(key, code)
    if key == 'return' and self.level then
        Transition.crossfade(self, Loading, self.level.index + 1)
    end
end
