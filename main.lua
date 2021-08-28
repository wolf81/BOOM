require 'src/dependencies'

-- show live output in console, don't wait for app to close
io.stdout:setvbuf("no")

local level = nil

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

local function prepareAudioPlayer()
    -- register music with audio player
    local musicFiles = love.filesystem.getDirectoryItems('mus')
    for _, musicFile in ipairs(musicFiles) do
        local name = musicFile:gsub('%.wav', '')
        local path = 'mus/' .. musicFile
        AudioPlayer.registerMusic(name, path)
    end

    -- register sounds with audio player
    local soundFiles = love.filesystem.getDirectoryItems('sfx')
    for _, soundFile in ipairs(soundFiles) do
        local name = soundFile:gsub('%.wav', '')
        local path = 'sfx/' .. soundFile
        AudioPlayer.registerSound(name, path)
    end

end

function love.load(args)
    love.math.setRandomSeed(love.timer.getTime())

    local contents, size = love.filesystem.read('version.txt')
    local version = contents:gsub('_', '.')

    prepareAudioPlayer()

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

	level = Level(1)
end

function love.update(dt)
	level:update(dt)
end

function love.draw()
	level:draw()
end