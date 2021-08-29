BonusBar = Object:extend()

function BonusBar:new()
	self._bonusIcons = love.graphics.newImage('gfx/Bonus Icons.png')
	self._quads = generateQuads(self._bonusIcons, 15, 15)
end

function BonusBar:update(dt)
	-- body
end

function BonusBar:draw()
	love.graphics.setColor(0.5, 0.5, 0.5, 1.0)
	
	for i = 0, 4 do
		love.graphics.draw(self._bonusIcons, self._quads[i + 1], i * 13, 50)
	end

	love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
end