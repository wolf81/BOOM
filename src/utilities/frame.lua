Frame = Object:extend()

function Frame:new(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
end

function Frame:intersects(frame)
	if (frame.x >= self.x + self.width or
		frame.x + frame.width <= self.x or
		frame.y >= self.y + self.height or
		frame.y + frame.height <= self.y) then 
		return false
	end

	return true
end

function Frame:__tostring()
	local s = ''

	for k, v in pairs(self) do
		s = s .. k .. ' = ' .. tostring(v) .. ', '
	end

	return 'Frame { ' .. s .. ' }'
end