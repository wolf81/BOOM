Loading = Class {}

function Loading:init() 
	-- body
end

function Loading:enter(previous, level_idx)
	local level = Level(level_idx)
	Transition.crossfade(self, Game, level)
end

function Loading:update(dt)
	-- body
end

function Loading:draw()
	local width, height = love.graphics.getWidth(), love.graphics.getHeight()

	love.graphics.setColor(0.0, 0.0, 0.0)
	love.graphics.rectangle('fill', 0, 0, width, height)
end
