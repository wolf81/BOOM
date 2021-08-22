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
	self._players = {}
	self._monsters = {}
	self._blocks = {}

	for i = 1, #self._gridDescString do
		local c = self._gridDescString:sub(i,i)

		local y = math.floor((i - 1) / Map.WIDTH) + 1
		local x = (i - 1) % Map.WIDTH + 1

		if c == 'X' or c == 'Y' then
			self._players[#self._players + 1] = Player(x, y, c == 'X' and 1 or 2)
		end

		if c == 'A' then
			self._monsters[#self._monsters + 1] = Monster(x, y)
		end

		if c == '1' or c == '2' then
			self._blocks[#self._blocks + 1] = Block(x, y, c == '2')

			local node = graph:nodeAt(x, y)
			graph:remove(node)
		end
    end

    print('\n' .. tostring(graph))
end