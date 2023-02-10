--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Hud = Class {}

function Hud:init(level)
	assert(level ~= nil, 'level is required')

	self.level = level
	self.panel = love.graphics.newImage('gfx/Panel.png')

	self.time_view = TimeView()

	self.p1_view = PlayerView(1)
	self.p2_view = PlayerView(2)
end

function Hud:update(dt)
	self.time_view:updateTime(self.level.time)

	for idx, player in ipairs(self.level.players) do
		if idx == 1 then
			self.p1_view:updateForPlayer(player)
		else
			self.p2_view:updateForPlayer(player)
		end
	end
end

function Hud:draw()
	love.graphics.draw(self.panel)

	self.time_view:draw(20, HUD_H / 2 - 7)

	self.p1_view:draw(14, 60)
	self.p2_view:draw(14, 270)
end
