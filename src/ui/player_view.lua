--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

PlayerView = Class {}

function PlayerView:init()
	self.health_bar = HealthBar()
	self.extra_bar = ExtraBar()
	self.bonus_bar = BonusBar()
	self.score_view = ScoreView()
end

function PlayerView:updateForPlayer(player)
	self.health_bar:updateHitpoints(player.hitpoints.current)
	self.extra_bar:updateExtraFlags(player.extra_flags)
	self.bonus_bar:updateBonusFlags(player.bonus_flags)
	self.score_view:updateScore(player.score)
end

function PlayerView:draw(x, y)
	self.health_bar:draw(x, y)
	self.extra_bar:draw(x, y + 40)
	self.bonus_bar:draw(x, y + 60)
	self.score_view:draw(x, y + 80)
end