AudioPlayer = {}

local settings = {
	music_volume = 1.0,
	sound_volume = 1.0,
}

function AudioPlayer.setMusicVolume(volume)
	settings.music_volume = volume
end

function AudioPlayer.setSoundVolume(volume)
	settings.sound_volume = volume
end

function AudioPlayer.playMusic(path, looping)
	local music = love.audio.newSource(path, 'stream')
    music:setVolume(settings.music_volume)
    music:setLooping(looping or true)
    love.audio.play(music) 
end

function AudioPlayer.playSound(path)
	local sound = love.audio.newSource(path, 'static')
	sound:setVolume(settings.sound_volume)
	love.audio.play(sound)
end
