Game = Class { __includes = SceneBase }

local function proceedNextLevel(self)
	self.accept_input = false
	local level = LevelLoader.load(self.level.index + 1)
	if level then
		Transition.crossfade(self, Game, level)
	else
		Transition.crossfade(self, Loading, 1)
	end
end

function Game:init()
	SceneBase.init(self)
end

function Game:enter(previous, level)
	self.level = level
	print('level ' .. level.index)
end

function Game:onFinishTransition()
	self.accept_input = true
end

function Game:update(dt)
	self.level:update(dt)
end

function Game:draw()
	self.level:draw()
end

function Game:keyreleased(key, code)
	if not self.accept_input then return end

	self.level:keyreleased(key, code)

    if key == 'return' then
    	proceedNextLevel(self)
    end
end
