--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

TILE_W = 32
TILE_H = 32

TILE_SIZE = vector(TILE_W, TILE_H)

MAP_W = 15
MAP_H = 13

HUD_W = 96
HUD_H = 480

WINDOW_W = TILE_W * (MAP_W + 2) + HUD_W
WINDOW_H = math.max(TILE_H * (MAP_H + 2), HUD_H)