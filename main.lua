require 'src/dependencies'

function love.load(args)
	print('load')

    love.math.setRandomSeed(love.timer.getTime())

    local contents, size = love.filesystem.read('version.txt')
    local version = contents:gsub('_', '.')

	love.window.setTitle('BOOM (' .. version .. ')')
end

function love.update(dt)
	-- body
end

function love.draw()
	-- body
end