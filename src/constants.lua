TileSize = vector(32, 32)
TileSize.w = TileSize.x
TileSize.h = TileSize.y

Direction = {
	UP = vector(0, -1),
	DOWN = vector(0, 1),
	LEFT = vector(-1, 0),
	RIGHT = vector(1, 0),
	NONE = vector(0, 0),

	opposite = function(dir)
		return dir:permul(vector(-1, -1))
	end
}

Orientation = {
	HORIZONTAL = 0,
	VERTICAL = 1,
}

function toGridPosition(position)
	local x = math.floor(position.x / TileSize.x) 
	local y = math.floor(position.y / TileSize.y)
	return vector(x, y)
end

function toPosition(gridPosition)
	local position = gridPosition:permul(TileSize)
	return position
end