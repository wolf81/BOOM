require 'src/dependencies'

-- show live output in console, don't wait for app to close
io.stdout:setvbuf("no")

local level = nil

backgroundPatterns = {
    ['1'] = love.graphics.newImage('gfx/BGPattern 02.png'),
    ['2'] = love.graphics.newImage('gfx/BGPattern 03.png'),
    ['3'] = love.graphics.newImage('gfx/BGPattern 04.png'),
    ['4'] = love.graphics.newImage('gfx/BGPattern 05.png'),
}

borders = {
    ['0'] = love.graphics.newImage('gfx/Border 01.png'),
    ['1'] = love.graphics.newImage('gfx/Border 02.png'),
    ['2'] = love.graphics.newImage('gfx/Border 03.png'),
    ['3'] = love.graphics.newImage('gfx/Border 04.png'),
}

function love.load(args)
    love.math.setRandomSeed(love.timer.getTime())

    local contents, size = love.filesystem.read('version.txt')
    local version = contents:gsub('_', '.')

    --[[
    local modes = love.window.getFullscreenModes(1)
    for _, mode in ipairs(modes) do
    	print(mode.width, mode.height)
    end
    ]]

	love.window.setTitle('BOOM (' .. version .. ')')

    DataLoader:load('dat/entities', function(data)
        EntityFactory:register(data)
    end)

	level = Level(31)
end

function love.update(dt)
	level:update(dt)
end

function love.draw()
	level:draw()
end