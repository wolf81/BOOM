local EntityFactory = {}

local registry = {}
--local textureCache = {}


-- create a deep clone of a table
local function clone(obj)
    if type(obj) ~= 'table' then return obj end
    local res = setmetatable({}, getmetatable(obj))
    for k, v in pairs(obj) do 
    	res[clone(k)] = clone(v) end
    return res
end

local function createPrototype(data)
	if data.type == 'Block' then
		return Block(data)
	elseif data.type == 'Monster' then
		return Monster(data)
	elseif data.type == 'Player' then		
		return Player(data)
	elseif data.type == 'Bonus' then
		return Bonus(data)
	end

	error('unknown type: ' .. data.type)
end

-- register a prototype based on a data file
function EntityFactory:register(data)
	assert(data.id ~= nil, 'id is required')
	assert(data.type ~= nil, 'type is required')
	assert(data.texture ~= nil, 'texture is required')
	assert(love.filesystem.getInfo(data.texture), 'texture file does not exist: ' .. data.texture)

	local id = data.id:lower()
	registry[id] = createPrototype(data)	
end

-- create a new instance from a prototype
function EntityFactory:create(id, position)
	assert(id ~= nil, 'id is required')

	local prototype = registry[id:lower()]
	assert(prototype ~= nil, 'id not registered: ' .. id)

	local instance = clone(prototype)
	instance:setPosition(position)
	instance:idle()

	return instance
end

return EntityFactory