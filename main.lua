require 'src/dependencies'

-- show live output in console, don't wait for app to close
io.stdout:setvbuf("no")

local level = nil

backgroundPatterns = {
    ['1'] = love.graphics.newImage('gfx/BGPattern 02.png')
}

function love.load(args)
	print('load')

    love.math.setRandomSeed(love.timer.getTime())

    local contents, size = love.filesystem.read('version.txt')
    local version = contents:gsub('_', '.')

    local modes = love.window.getFullscreenModes(1)
    for _, mode in ipairs(modes) do
    	print(mode.width, mode.height)
    end

	love.window.setTitle('BOOM (' .. version .. ')')

	level = Level(1)
end

function love.update(dt)
	level:update(dt)
end

function love.draw()
	level:draw()
end