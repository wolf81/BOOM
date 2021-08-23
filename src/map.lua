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
	self._bblocks = {}
	self._fblocks = {}
	self._bonuses = {}

	for i = 1, #self._gridDescString do
		local c = self._gridDescString:sub(i,i)

		local y = math.floor((i - 1) / Map.WIDTH) + 1
		local x = (i - 1) % Map.WIDTH + 1
		local pos = vector(x, y)

		local tileInfo = { pos = pos, id = c }

		if c == 'X' or c == 'Y' then
			self._players[#self._players + 1] = tileInfo
		elseif c == 'A' then
			self._monsters[#self._monsters + 1] = tileInfo
		elseif c == '1' then
			self._fblocks[#self._fblocks + 1] = tileInfo
			local node = graph:nodeAt(x, y)
			graph:remove(node)
		elseif c == '2' then
			self._bblocks[#self._bblocks + 1] = tileInfo
			local node = graph:nodeAt(x, y)
			graph:remove(node)
		elseif c == '3' then
			self._bonuses[#self._bonuses + 1] = tileInfo			
		end
    end

    print('\n' .. tostring(graph))
end

function Map:players()
	return self._players
end

function Map:monsters()
	return self._monsters
end

function Map:bblocks()
	return self._bblocks
end

function Map:fblocks()
	return self._fblocks
end

function Map:bonuses()
	return self._bonuses
end