BonusBar = Object:extend()

local font = {
	BONUS = love.graphics.newFont('fnt/pf_tempesta_seven_bold.ttf', 20),
}

function BonusBar:new()
	self._bonusIcons = love.graphics.newImage('gfx/Bonus Icons.png')
	self._quads = generateQuads(self._bonusIcons, 15, 15)
	self._bonuses = { 
		0, 0, 0, 0, 0,
	}
end

function BonusBar:updateBonuses(bonuses)
	for idx, bonus in ipairs(bonuses) do
		self._bonuses[idx] = bonus:amount()
	end
end

function BonusBar:draw()
	for i = 0, 4 do
		local count = self._bonuses[i + 1]
		local quadIdx = count == 0 and i + 6 or i + 1
		love.graphics.draw(self._bonusIcons, self._quads[quadIdx], i * 13, 48)

		love.graphics.setFont(font.BONUS)

		if count > 1 then
			love.graphics.printf('x' .. count, i * 13, 60, 50, 'left', 0, 0.4, 0.4)
		end
	end
end