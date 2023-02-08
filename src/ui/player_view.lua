--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

PlayerView = Class {}

function PlayerView:init(player_idx)
	assert(player_idx ~= nil, 'player_idx is required')
	self.head_image = love.graphics.newImage('gfx/Player ' .. player_idx .. ' Head.png')
	self.health_bar = HealthBar()
	self.extra_bar = ExtraBar()
	self.bonus_bar = BonusBar()
	self.score_view = ScoreView()

	self.lives = 0
	self.font = love.graphics.newImageFont('gfx/BigLettersFont.png', ' !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~')
end

function PlayerView:updateForPlayer(player)
	self.lives = player.lives

	self.health_bar:updateHitpoints(player.hitpoints.current)
	self.extra_bar:updateExtraFlags(player.extra_flags)
	self.bonus_bar:updateBonusFlags(player.bonus_flags)
	self.score_view:updateScore(player.score)
end

function PlayerView:draw(x, y)
	love.graphics.draw(self.head_image, x, y)

	love.graphics.setFont(self.font)
	love.graphics.print('*' .. self.lives, x + 40, y + 3)
	self.health_bar:draw(x, y + 30)
	self.extra_bar:draw(x, y + 70)
	self.bonus_bar:draw(x, y + 90)
	self.score_view:draw(x, y + 118)
end