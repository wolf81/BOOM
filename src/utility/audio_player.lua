--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local lume_ripairs, table_remove, table_insert = lume.ripairs, table.remove, table.insert

AudioPlayer = {}

local settings = {
	music_volume = 1.0,
	sound_volume = 1.0,
}

local music = nil

local sources = {}

local registry = {}

function AudioPlayer.load(path)
	assert(path ~= nil, 'path is required')

	print('load @ ' .. path)

	registry[path] = love.audio.newSource(path, 'static')
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
	for idx, source in lume_ripairs(sources) do
		if not source:isPlaying() then
			table_remove(sources, idx)
		end
	end

	local source = registry[path]:clone()

	table_insert(sources, source)
	source:setVolume(settings.sound_volume)
	source:play()
end
