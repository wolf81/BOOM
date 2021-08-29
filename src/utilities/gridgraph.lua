local GridGraphNode = Object:extend()

local function isConnected(self, node)
	for i, connectedNode in ipairs(self._connectedNodes) do
		if node == connectedNode then
			return true, i
		end
	end

	return false, nil
end

function GridGraphNode:new(x, y)
	self._position = {x, y}
	self._connectedNodes = {} 
end

function GridGraphNode:position()
	return unpack(self._position)
end

function GridGraphNode:isConnected(node)
	if node == nil then return false end

	local connected, _ = isConnected(self, node)
	return connected
end

function GridGraphNode:connect(node)
	local connected, i = isConnected(self, node)

	if not connected then
		self._connectedNodes[#self._connectedNodes + 1] = node			
	end
end

function GridGraphNode:disconnect(node)
	local connected, i = isConnected(self, node)
	if connected then
		table.remove(self._connectedNodes, i)
	end
end

function GridGraphNode:connectedNodes()
	return self._connectedNodes
end

--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]--[[--]]

GridGraph = Object:extend()

local function newGraph(width, height)
	local graph = {}

	for y = 1, height do
		graph[y] = {}
		for x = 1, width do
			graph[y][x] = GridGraphNode(x, y)
		end
	end

	return graph
end

function GridGraph:new(width, height)
	assert(width ~= nil and height ~= nil, 'width and height required')
	assert(width > 0 and height > 0, 'width and height should be larger than 0')

	self._width = width
	self._height = height
	self._graph = newGraph(self._width, self._height)

	for y = 1, self._height do
		for x = 1, self._width do
			local node = self._graph[y][x]
			self:connectToAdjacentNodes(node)
		end
	end
end 

function GridGraph:nodeAt(x, y)
	if x < 1 or x > self._width then return nil end
	if y < 1 or y > self._height then return nil end

	return self._graph[y][x]
end

function GridGraph:remove(node)
	local x, y = node:position()

	self:disconnectFromAdjacentNodes(node)

	self._graph[y][x] = nil
end

function GridGraph:add(x, y)
	-- body
end

function GridGraph:disconnectFromAdjacentNodes(node)
	for _, connectedNode in ipairs(node:connectedNodes()) do
		node:disconnect(connectedNode)
		connectedNode:disconnect(node)
	end
end

function GridGraph:connectToAdjacentNodes(node)
	local nx, ny = node:position()
	local x1, x2 = nx - 1, nx + 1
	local y1, y2 = ny - 1, ny + 1

	local coords = {
		{ x1, ny }, 
		{ x2, ny }, 
		{ nx, y1 }, 
		{ nx, y2 },		
	}

	for _, coord in ipairs(coords) do
		local x, y = coord[1], coord[2]
		local graphNode = self:nodeAt(x, y)
		if graphNode ~= nil then
			node:connect(graphNode)
			graphNode:connect(node)
		end
	end
end

function GridGraph:width()
	return self._width
end

function GridGraph:height()
	return self._height
end

function GridGraph:__tostring()
	local s = ''
	
	for y = 1, self._height do
		for x = 1, self._width do
			local n = self:nodeAt(x, y)
			s = s .. (n == nil and ' ' or 'O')
		end

		s = s .. '\n'
	end

	return s
end
