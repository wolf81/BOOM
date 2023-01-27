--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Direction =  {
	UP = vector(0, -1),
	DOWN = vector(0, 1),
	LEFT = vector(-1, 0),
	RIGHT = vector(1, 0),
	NONE = vector(0, 0),
}

function GetDirectionName(dir)
	for k, v in pairs(Direction) do
		if v == dir then return k end
	end

	return nil
end
