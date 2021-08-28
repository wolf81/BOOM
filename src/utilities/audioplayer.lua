AudioPlayer = {}

local registry = {
	music = {},
	sound = {},
}

local settings = {
	musicVolume = 1.0
}

function AudioPlayer.setMusicVolume(volume)
	settings.musicVolume = volume
end

function AudioPlayer.registerMusic(name, path)
	assert(name ~= nil, 'name is required')
	assert(path ~= nil, 'path is required')

	registry.music[name] = path
end

function AudioPlayer.registerSound(name, path)
	assert(name ~= nil, 'name is required')
	assert(path ~= nil, 'path is required')

	registry.sound[name] = path
end

function AudioPlayer.playMusic(name, looping)
	local path = registry.music[name]
	local music = love.audio.newSource(path, 'stream')
    music:setVolume(settings.musicVolume)
    music:setLooping(looping or true)
    love.audio.play(music) 
end

function AudioPlayer.playSound(name)
	local path = registry.sound[name]
	local sound = love.audio.newSource(path, 'static')
	love.audio.play(sound)
end