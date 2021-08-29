QuadCache = {}

local cache = {}

function QuadCache:register(entity, spriteSize)
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