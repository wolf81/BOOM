--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_floor = math.floor

LevelComplete = Class { __includes = SceneBase }

local function generateBackground()
	local canvas = love.graphics.newCanvas(WINDOW_W - HUD_W, WINDOW_H)

	canvas:renderTo(function()
		love.graphics.setCanvas(canvas)
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
	end)

	return canvas
end

local function proceedNextLevel(self)
	local level, background = LevelLoader.load(self.level.index + 1)

	-- copy player state over from player in last level to player in next level
	for _, old_player in ipairs(self.level.players) do
		for _, new_player in ipairs(level.players) do
			if old_player.name == new_player.name then
				new_player.bonus_flags = old_player.bonus_flags
				new_player.extra_flags = old_player.extra_flags
				new_player.score = old_player.score
				new_player.lives = old_player.lives
				new_player.hitpoints = old_player.hitpoints
			end
		end
	end

	if level then
		Transition.crossfade(self, Game, level, background)
	else
		Transition.crossfade(self, Loading, 1)
	end
end

function LevelComplete:init()
	SceneBase.init(self)

	self.font = love.graphics.newImageFont('gfx/BigLettersFontCondensed.png', ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~', 1)
	self.background = generateBackground()
end

function LevelComplete:enter(previous, level)
	self.level = level
	self.hud = Hud(self.level)

	self.message1 = 'TIME BONUS!'
	self.message2 = math_floor(self.level.time) * 10

	-- remove temporary bonuses
	for _, player in ipairs(self.level.players) do
		player.bonus_flags = ClearMask(player.bonus_flags, bit.bor(BonusFlags.SHIELD, BonusFlags.BOOTS))
	end

	Timer.after(3.0, function() proceedNextLevel(self) end)
end

function LevelComplete:update(dt)
	self.hud:update(dt)
end

function LevelComplete:draw()
	love.graphics.push()
	love.graphics.translate(HUD_W, 0)
	love.graphics.draw(self.background)

	love.graphics.setFont(self.font)
	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
	local h = self.font:getHeight() + 10

	local w = self.font:getWidth(self.message1)
	love.graphics.print(self.message1, math_floor((WINDOW_W - HUD_W - w) / 2), math_floor(WINDOW_H / 2 - h / 2))

	w = self.font:getWidth(self.message2)
	love.graphics.print(self.message2, math_floor((WINDOW_W - HUD_W - w) / 2), math_floor(WINDOW_H / 2 + h / 2))

	love.graphics.pop()

	self.hud:draw()
end
