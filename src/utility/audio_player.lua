--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

AudioPlayer = {}

local settings = {
	music_volume = 1.0,
	sound_volume = 1.0,
}

local music = nil

local sources = {}

function AudioPlayer.load(path)
	assert(path ~= nil, 'path is required')

	sources[path] = love.audio.newSource(path, 'static')
end

function AudioPlayer.setMusicVolume(volume)
	settings.music_volume = volume
end

function AudioPlayer.setSoundVolume(volume)
	settings.sound_volume = volume
end

function AudioPlayer.playMusic(path, looping)
	if music then music:stop() end

	music = love.audio.newSource(path, 'stream')
    music:setVolume(settings.music_volume)
    music:setLooping(looping or true)
    love.audio.play(music) 
end

function AudioPlayer.playSound(path)
	assert(sources[path] ~= nil, 'sound not loaded: ' .. path)

	local sound = sources[path]
	sound:setVolume(settings.sound_volume)
	sound:play()
end
