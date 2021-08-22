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

	for i = 1, #self._gridDescString do
		local c = self._gridDescString:sub(i,i)

		local y = math.floor((i - 1) / Map.WIDTH)
		local x = (i - 1) % Map.WIDTH

		if not (c == '0' or c == 'X' or c == 'Y' or c == 'A') then
			local node = graph:nodeAt(x + 1, y + 1)
			graph:remove(node)
		end
    end

    print('\n' .. tostring(graph))
end