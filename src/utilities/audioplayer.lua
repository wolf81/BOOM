AudioPlayer = {}

local settings = {
	musicVolume = 1.0,
	soundVolume = 1.0,
}

function AudioPlayer.setMusicVolume(volume)
	settings.musicVolume = volume
end

function AudioPlayer.setSoundVolume(volume)
	settings.soundVolume = volume
end

function AudioPlayer.playMusic(path, looping)
	local music = love.audio.newSource(path, 'stream')
    music:setVolume(settings.musicVolume)
    music:setLooping(looping or true)
    love.audio.play(music) 
end

function AudioPlayer.playSound(path)
	local sound = love.audio.newSource(path, 'static')
	sound:setVolume(settings.soundVolume)
	love.audio.play(sound)
end