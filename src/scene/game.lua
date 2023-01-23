Game = Class {}

function Game:init()
	-- body
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
