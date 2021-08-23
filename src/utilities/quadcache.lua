QuadCache = {}

local cache = {}

local function generateQuads(texture)
	local tw, th = texture:getDimensions()

	local quads = {}
	for y = 0, (th - 32), 32 do
		for x = 0, (tw - 32), 32 do
			local quad = love.graphics.newQuad(x, y, 32, 32, tw, th)
			quads[#quads + 1] = quad
		end
	end

	return quads
end

function QuadCache:register(entity)
	print(entity._data.id)
	if cache[entity._data.id] == nil then
		local texture = love.graphics.newImage(entity:texture())
		local quads = generateQuads(texture)
		cache[entity._data.id] = { texture, quads }
		print('quads:', entity._data.id, #quads)
	end
end

function QuadCache:get(entity)
	return unpack(cache[entity._data.id])
end