GridGraph = Class {}

function GridGraph:init(width, height)
	self.graph = {}

	for y = 1, height do
		self.graph[y] = {}

		for x = 1, width do
			self.graph[y][x] = 1
		end
	end
end

function GridGraph:removeNode(x, y)
	self.graph[y][x] = 0
end

function GridGraph:hasNode(x, y)
	return graph[y][x] == 1
end

function GridGraph:__tostring()
	local s = 'GridGraph {\n'
	for y = 1, #self.graph do
		s = s .. '\t'
		for x = 1, #self.graph[1] do
			s = s .. (self.graph[y][x] == 1 and '#' or ' ') .. ' '
		end
		s = s .. '\n'
	end
	return s .. '}'
end