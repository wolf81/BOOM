require 'src/dependencies'

-- show live output in console, don't wait for app to close
io.stdout:setvbuf("no")

local level = nil

backgroundPatterns = {
    ['1'] = love.graphics.newImage('gfx/BGPattern 02.png')
}

borders = {
    ['0'] = love.graphics.newImage('gfx/Border 01.png')    
}

borderQuads = {
    ['L'] = love.graphics.newQuad(0, 0, 32, 32, 256, 32),
    ['R'] = love.graphics.newQuad(32, 0, 32, 32, 256, 32),
    ['U'] = love.graphics.newQuad(64, 0, 32, 32, 256, 32),
    ['D'] = love.graphics.newQuad(96, 0, 32, 32, 256, 32),
    ['DL'] = love.graphics.newQuad(128, 0, 32, 32, 256, 32),
    ['DR'] = love.graphics.newQuad(160, 0, 32, 32, 256, 32),
    ['UR'] = love.graphics.newQuad(196, 0, 32, 32, 256, 32),
    ['UL'] = love.graphics.newQuad(228, 0, 32, 32, 256, 32),
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