require 'src/dependencies'

-- show live output in console, don't wait for app to close
io.stdout:setvbuf("no")

function love.load(args)
    love.math.setRandomSeed(love.timer.getTime())

    love.window.setMode(WINDOW_W, WINDOW_H, { fullscreen = false })

    local contents, size = love.filesystem.read('version.txt')
    local version = contents:gsub('_', '.')
	love.window.setTitle('BOOM (' .. version .. ')')

    AudioPlayer.setMusicVolume(0.0)
    AudioPlayer.setSoundVolume(0.01)

    love.keyboard.keysPressed = {}

    Transition.init(Loading, 79)
end

function love.update(dt)
    Timer.update(dt)

    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed = {}
end

function love.keypressed(key, code)
    love.keyboard.keysPressed[key] = true    
end
