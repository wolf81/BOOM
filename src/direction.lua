Direction =  {
	up = vector(0, -1),
	down = vector(0, 1),
	left = vector(-1, 0),
	right = vector(1, 0),
	none = vector(0, 0),
}

function GetDirectionName(dir)
	for k, v in pairs(Direction) do
		if v == dir then return k end
	end

	return nil
end

