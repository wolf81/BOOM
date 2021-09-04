require 'src/dependencies'

-- show live output in console, don't wait for app to close
io.stdout:setvbuf("no")

local game = nil

backgroundPatterns = {
    ['1'] = love.graphics.newImage('gfx/BGPattern 02.png'),
    ['2'] = love.graphics.newImage('gfx/BGPattern 03.png'),
    ['3'] = love.graphics.newImage('gfx/BGPattern 04.png'),
    ['4'] = love.graphics.newImage('gfx/BGPattern 05.png'),
    ['5'] = love.graphics.newImage('gfx/BGPattern 06.png'),
    ['6'] = love.graphics.newImage('gfx/BGPattern 07.png'),
    ['7'] = love.graphics.newImage('gfx/BGPattern 08.png'),
    ['8'] = love.graphics.newImage('gfx/BGPattern 09.png'),
}

borders = {
    ['0'] = love.graphics.newImage('gfx/Border 01.png'),
    ['1'] = love.graphics.newImage('gfx/Border 02.png'),
    ['2'] = love.graphics.newImage('gfx/Border 03.png'),
    ['3'] = love.graphics.newImage('gfx/Border 04.png'),
    ['4'] = love.graphics.newImage('gfx/Border 05.png'),
    ['5'] = love.graphics.newImage('gfx/Border 06.png'),
    ['6'] = love.graphics.newImage('gfx/Border 07.png'),
    ['7'] = love.graphics.newImage('gfx/Border 08.png'),
}

function love.load(args)
    love.math.setRandomSeed(love.timer.getTime())

    AudioPlayer.setMusicVolume(0.0)
    AudioPlayer.setSoundVolume(0.01)

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

    game = Game(1)
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end