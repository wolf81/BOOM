Game = Class {}

function Game:init()
	print('game')
end

function Game:enter(previous, level_idx)
	self.level = Level(level_idx)	
end

function Game:update(dt)
	self.level:update(dt)
end

function Game:draw()
	self.level:draw()
end
