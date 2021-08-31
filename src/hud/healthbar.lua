HealthBar = Object:extend()

local HeartType = {
	EMPTY = 1,
	HALF = 2,
	FULL = 3,
}

function HealthBar:new()
	self._heartIcons = love.graphics.newImage('gfx/Heart Icons.png')
	self._quads = generateQuads(self._heartIcons, 18, 18)

	self._hearts = {
		HeartType.EMPTY, HeartType.EMPTY, HeartType.EMPTY, HeartType.EMPTY, 
		HeartType.EMPTY, HeartType.EMPTY, HeartType.EMPTY, HeartType.EMPTY,
	}
end

function HealthBar:updateHealth(health)
	local fullHearts = math.floor(health / 2)
	local halfHearts = health % 2
	local emptyHearts = math.floor(health / 2)

	for i = 1, fullHearts do 
		self._hearts[i] = HeartType.FULL
	end

	if halfHearts == 1 then
		self._hearts[fullHearts + 1] = HeartType.HALF
	end

	local emptyIdx = math.ceil(health / 2) + 1
	for i = emptyIdx, 8 do
		self._hearts[i] = HeartType.EMPTY
	end
end

function HealthBar:draw()
	local hearts = self._hearts

	for y = 0, 1 do
		for x = 0, 3 do
			local heartIdx = y * 4 + (x + 1)
			local quadIdx = self._hearts[heartIdx]	
			love.graphics.draw(self._heartIcons, self._quads[quadIdx], x * 16, y * 16)
		end
	end
end