--[[
	X00020200002000
	012101210121010
	000020202300002
	012101010121010
	2300A0002000202
	010121010121010
	000200203020000
	210121010121010
	2002000220A0032
	012131012121010
	000020200000220
	212101012101010
	00200200002000Y
]]

Map = Object:extend()
Map.WIDTH = 15
Map.HEIGHT = 13

function Map:new(gridDescString)
	local graph = GridGraph(Map.WIDTH, Map.HEIGHT)

	self._gridDescString = gridDescString
	self._entityInfos = {}

	for i = 1, #self._gridDescString do
		local c = self._gridDescString:sub(i,i)

		local y = math.floor((i - 1) / Map.WIDTH) + 1
		local x = (i - 1) % Map.WIDTH + 1
		local pos = vector(x, y)

		if c ~= '0' then
			self._entityInfos[#self._entityInfos + 1] = { pos = pos, id = c }
		end

		if c == '1' or c == '2' then
			local node = graph:nodeAt(x, y)
			graph:remove(node)
		end
    end

    print('\n' .. tostring(graph))
end

function Map:entityInfos()
	return self._entityInfos
end