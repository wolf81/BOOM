--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

require 'src/dependencies'

local lurker = require 'lib.lurker.lurker'

-- show live output in console, don't wait for app to close
io.stdout:setvbuf("no")

function love.load(args)
    love.math.setRandomSeed(love.timer.getTime())

    love.filesystem.setIdentity('boom')

    love.window.setMode(WINDOW_W, WINDOW_H, { fullscreen = false })

    local contents, size = love.filesystem.read('version.txt')
    local version = contents:gsub('_', '.')
	love.window.setTitle('BOOM (' .. version .. ')')

    local volume = 0.0
    AudioPlayer.setMusicVolume(volume)
    AudioPlayer.setSoundVolume(volume)

    Transition.init(Loading, 56)
end

function love.update(dt)
    lurker.update()

    Timer.update(dt)
end

function love.keypressed(key, code)
    if key == 'escape' then
        love.event.quit()
    end
end
