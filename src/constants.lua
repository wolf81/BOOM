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

LevelFlags = {
	DID_SHOW_EXTRA = bit.lshift(1, 0),
	DID_SHOW_HURRY = bit.lshift(1, 1),
}

ExtraFlags = {
	E = bit.lshift(1, 0),
	X = bit.lshift(1, 1),
	T = bit.lshift(1, 2),
	R = bit.lshift(1, 3),
	A = bit.lshift(1, 4),
}

BonusFlags = {
	EXTRA_BOMB = bit.lshift(1, 0),
	SHORT_FUSE = bit.lshift(1, 1),
	EXPLODE_SIZE = bit.lshift(1, 2),
	SHIELD = bit.lshift(1, 3),
	BOOTS = bit.lshift(1, 4),
	HEAL_ONE = bit.lshift(1, 5),
	HEAL_ALL = bit.lshift(1, 6),
	DESTROY_BLOCKS = bit.lshift(1, 7),
	DESTROY_MONSTERS = bit.lshift(1, 8),
}

BonusMasks = {
	BOMB_COUNT = 0x7000,
	EXPLODE_COUNT = 0x18000,
}

CategoryFlags = {	
	PLAYER = bit.lshift(1, 0),
	MONSTER = bit.lshift(1, 1),
	COIN = bit.lshift(1, 2),
	TELEPORTER = bit.lshift(1, 3),
	FIXED_BLOCK = bit.lshift(1, 4),
	BREAKABLE_BLOCK = bit.lshift(1, 5),
	EXPLOSION = bit.lshift(1, 6),
	PROJECTILE = bit.lshift(1, 7),
	BONUS = bit.lshift(1, 8),
	EXTRA = bit.lshift(1, 9),
}
