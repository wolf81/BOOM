TileSize = vector(32, 32)

Direction = {
	['UP'] = vector(0, -1),
	['DOWN'] = vector(0, 1),
	['LEFT'] = vector(-1, 0),
	['RIGHT'] = vector(1, 0),
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