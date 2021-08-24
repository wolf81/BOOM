QuadCache = {}

local cache = {}

local function generateQuads(texture, spriteWidth, spriteHeight)
	local tw, th = texture:getDimensions()

	local quads = {}
	for y = 0, (th - spriteHeight), spriteHeight do
		for x = 0, (tw - spriteWidth), spriteWidth do
			local quad = love.graphics.newQuad(x, y, spriteWidth, spriteHeight, tw, th)
			quads[#quads + 1] = quad
		end
	end

	return quads
end

function QuadCache:register(entity, spriteSize)
	spriteSize = spriteSize or { 32, 32 }
	print(spriteSize[1], spriteSize[2])

	if cache[entity._data.id] == nil then
		local texture = love.graphics.newImage(entity:texture())
		local quads = generateQuads(texture, spriteSize[1], spriteSize[2])
		cache[entity._data.id] = { texture, quads }
	end
end

function QuadCache:get(entity, frames)
	local texture, quads = unpack(cache[entity._data.id])
	local index = frames[1]
	local length = frames[2] - 1
	quads = lume.slice(quads, index, index + length)
	return texture, quads
end