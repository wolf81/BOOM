--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Hud = Class {}

function Hud:init(level, show_level)
	assert(level ~= nil, 'level is required')

	self.level = level
	self.panel = love.graphics.newImage('gfx/Panel.png')

	self.time_view = TimeView()
	self.level_view = LevelView(level.index)

	self.show_level = show_level

	self.p1_view = PlayerView(1)
	self.p2_view = PlayerView(2)
end

function Hud:update(dt)
	self.time_view:updateTime(self.level.time)

	for _, player in ipairs(self.level.players) do
		if player.key == 'X' then
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

	if self.show_level then
		local view_w, _ = self.level_view:getSize()
		self.level_view:draw(WINDOW_W - view_w - 2, 2)
	end
end
