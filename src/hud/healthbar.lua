HealthBar = Object:extend()

function HealthBar:new()
	self._heartIcons = love.graphics.newImage('gfx/Heart Icons.png')
	self._quads = generateQuads(self._heartIcons, 18, 18)
end

function HealthBar:update(dt)
	-- body
end

function HealthBar:draw()
	for y = 0, 1 do
		for x = 0, 3 do
			love.graphics.draw(self._heartIcons, self._quads[3], x * 16, y * 16)
		end
	end
end