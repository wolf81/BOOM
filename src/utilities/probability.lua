Probability = Object:extend()

function Probability:new(items)
	self._items = {}
	self._sum = 0

	local items = items or {}
	for id, chance in pairs(items) do
		self:add(id, chance)
	end
end

function Probability:add(id, chance)
	self._items[#self._items + 1] = { id = id, chance = self._sum }
	self._sum = self._sum + chance
end

function Probability:random()
	local v = love.math.random(self._sum)
	local id = self._items[1].id
	
	for _, item in ipairs(self._items) do
		if item.chance >= v then break end

		id = item.id
	end

	return id
end