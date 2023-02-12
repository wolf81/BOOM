--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

return {
	['1'] = {
		name = 'Fixed Block',
		texture = 'gfx/Fixed Blocks.png',
		animations = {},
	},
	['2'] = {
		name = 'Breakable Block',
		texture = 'gfx/Breakable Blocks.png',
		value = 10,
		animations = {
			['destroy'] = {
				frames = { 2, 3, 4 },
				interval = 0.1,
			},
		},
		sounds = {
			['destroy'] = 'sfx/BlockDestruction.wav',
		},
	},
	['3'] = {
		name = 'Coin',
		texture = 'gfx/Coin.png',
		value = 150,
		animations = {
			['destroy'] = {
				frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
				interval = 0.025,
				times = 6,
			},
		},
		sounds = {
			['destroy'] = 'sfx/Coin.wav',
		},
	},
	['A'] = {
		name = 'Soldier',
		description = 'This only apparently human creature is pretty stupid. Moves erratically. Almost harmless.',
		texture = 'gfx/Soldier.png',
		value = 200,
		attack = {
			projectile = 'shot',
			rate = 1.0,
		},
		animations = {
			['idle-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['idle-up'] = {
				frames = { 5 },
				interval = 0.1,
			},
			['idle-right'] = {
				frames = { 9 },
				interval = 0.1,
			},
			['idle-left'] = {
				frames = { 13 },
				interval = 0.1,
			},
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.2,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.2,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.2,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.2,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/SoldierDeath.wav',
		}
	},
	['B'] = {
		name = 'Sgt. Cool',
		description = 'He\'s tough, he\'s mean, he wears shades. In fact, the only difference with the soldier is a slightly higher fire rate.',
		texture = 'gfx/Sarge.png',
		value = 300,
		attack = {
			projectile = 'shot',
			rate = 0.8,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.1,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.1,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.1,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			-- TODO: this sound doesn't seem to be working, why?
			['destroy'] = 'sfx/SargeDeath.wav',
		}
	},
	['C'] = {
		name = 'Thick Lizzy',
		description = 'Part man, part reptile, all nastiness. This ugly beast casts deadly fireballs.',
		texture = 'gfx/Lizzy.png',
		value = 400,
		attack = {
			projectile = 'fireball',
			rate = 1.0,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.1,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.1,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.1,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 21, 22, 23, 24 },
				interval = 0.2,
				times = 2,
			},
		},
		sounds = {
			['destroy'] = 'sfx/LizzyDeath.wav',
		},
	},
	['D'] = {
		name = 'Mean-o-Taur',
		description = 'A sort of a cross between a man and a bull on steroids. Fast and extremely vicious.',
		speed = 60,
		texture = 'gfx/Taur.png',
		value = 500,
		attack = {
			rate = 0.5,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.1,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.1,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.1,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/TaurDeath.wav',
			['attack'] = 'sfx/TaurNoise.wav',
		},
	},
	['E'] = {
		name = 'Gunner',
		description = 'Another former human being. He holds a rapid-fire pulse rifle. Veeery dangerous!',
		texture = 'gfx/Gunner.png',
		value = 600,
		attack = {
			projectile = 'mg_shot',
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.3,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.3,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.3,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.3,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/GunnerDeath.wav',
		},
	},
	['F'] = {
		name = 'The \"Thing\"',
		description = 'The aliens\' favorite pet. Luckily our dogs don\'t spit energy bolts.',
		texture = 'gfx/Thing.png',
		value = 700,
		attack = {
			projectile = 'lightbolt',
			rate = 1.0,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.5,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.5,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.5,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.5,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/ThingDeath.wav',
		},
	},
	['G'] = {
		name = 'Ghost',
		description = 'This creature from beyond is unarmed but his fast and incessant attacks can be very annoying.',
		speed = 75,
		texture = 'gfx/Ghost.png',
		value = 800,
		attack = {
			rate = 0.5,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.1,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.1,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.1,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/GhostDeath.wav',
		},
	},
	['H'] = {
		name = 'Smoulder',
		description = 'A fat and ugly psycho killer. Keep away from his lethal flamethrower if you want to survive.',
		texture = 'gfx/Smoulder.png',
		value = 900,
		attack = {
			projectile = 'flame',
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.4,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.4,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.4,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.4,
			},
			['destroy'] = {
				frames = { 21, 22, 23, 24 },
				interval = 0.2,
				times = 2,
			},
		},
		sounds = {
			['destroy'] = 'sfx/SmoulderDeath.wav',
		},
	},
	['I'] = {
		name = 'Skully',
		description = 'A biomechanical creature. Its plasma cannon will wipe you out in seconds.',
		texture = 'gfx/Skully.png',
		value = 1000,
		attack = {
			projectile = 'plasma',
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.1,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.1,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.1,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/SkullyDeath.wav',
		},
	},
	['J'] = {
		name = 'H.R. Giggler',
		description = 'Your worst nightmare. The ultimate biological weapon. Throws radioactive magma and runs like a demon.',
		texture = 'gfx/Giggler.png',
		value = 1000,
		attack = {
			projectile = 'magma',
			rate = 0.3,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 17 },
				interval = 0.1,
			},
			['attack-up'] = {
				frames = { 18 },
				interval = 0.1,
			},
			['attack-right'] = {
				frames = { 19 },
				interval = 0.1,
			},
			['attack-left'] = {
				frames = { 20 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 21, 22 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/GigglerDeath.wav',
		}
	},
	['X'] = {
		name = 'Player 1',
		texture = 'gfx/Player1.png',
		speed = 90,
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4, 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 9, 10, 11, 12, 13, 14, 15, 16 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 17, 18, 19, 20, 21, 22, 23, 24 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 25, 26, 27, 28, 29, 30, 31, 32 },
				interval = 0.1,
			},
			['hit'] = {
				frames = { 37 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 33, 34, 35 },
				interval = 0.2,
				times = 4,
			},
		},
		sounds = {
			['destroy'] = 'sfx/P1Death.wav',
			['hit'] = 'sfx/P1Ouch.wav'
		},
	},
	['Y'] = {
		name = 'Player 2',
		texture = 'gfx/Player2.png',
		speed = 90,
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4, 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 9, 10, 11, 12, 13, 14, 15, 16 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 17, 18, 19, 20, 21, 22, 23, 24 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 25, 26, 27, 28, 29, 30, 31, 32 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 33, 34, 35 },
				interval = 0.2,
				times = 4,
			},
			['hit'] = {
				frames = { 37 },
				interval = 0.1,
			},
		},
		sounds = {
			['destroy'] = 'sfx/P2Death.wav',
			['hit'] = 'sfx/P2Ouch.wav',
		},
	},
	['alien'] = {
		name = 'Alien',
		texture = 'gfx/Alien Frames.png',
		value = 0,
		attack = {
			rate = 1.0,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['attack-down'] = {
				frames = { 1 },
				interval = 0.0,
			},
			['attack-up'] = {
				frames = { 1 },
				interval = 0.0,
			},
			['attack-right'] = {
				frames = { 1 },
				interval = 0.0,
			},
			['attack-left'] = {
				frames = { 1 },
				interval = 0.0,
			},
			['destroy'] = {
				frames = { 17, 18 },
				interval = 0.2,
				times = 5,
			},
		},
		sounds = {
			['destroy'] = 'sfx/AlienDeath.wav',
		},
	},
	['extra'] = {
		name = 'EXTRA',
		texture = 'gfx/EXTRA Letters.png',
		value = 0,
		animations = {
			['idle'] = {
				frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 },
				interval = 0.3,
			},
			['destroy'] = {
				frames = { 1 },
				interval = 0,
			},
		},
	},
	['*'] = {
		name = 'Head Boss',
		texture = 'gfx/Head Boss.png',
		sprite_size = { 96, 96 },
		value = 5000,
		attack = {
			projectile = 'head_missile',
			rate = 0.3,
		},
		animations = {
			['destroy'] = {
				frames = { 1 },
				interval = 2.0,
			},
		},
		sounds = {
			['destroy'] = 'sfx/HeadDeath.wav',
		},
	},
	['alien-boss'] = {
		name = 'Alien Boss',
		texture = 'gfx/Alien Boss.png',
		sprite_size = { 160, 160 },
		value = 100000,
		attack = {
			projectile = 'head_missile',
			rate = 1.0,
		},
		animations = {
			['move-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 13, 14, 15, 16 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 1 },
				interval = 2.0,
			},
		},
		sounds = {
			['destroy'] = 'sfx/BossDeath.wav',
		},
	},
	['+'] = {
		name = 'Teleporter',
		texture = 'gfx/Teleporter.png',
		animations = {
			['idle'] = {
				frames = { 1, 2, 3, 4, 5, 6, 7, 8 },
				interval = 0.2
			},
		},
	},
	['shot'] = {
		name = 'Shot',
		texture = 'gfx/Shot.png',
		size = 7,
		animations = {
			['propel-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-up'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-right'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-left'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 2, 3, 4, 5 },
				interval = 0.1,
			},
		},
		sounds = {
			['propel'] = 'sfx/Shot.wav',
		}
	},
	['flame'] = { -- bugged in level 72
		name = 'Flame',
		texture = 'gfx/Flame.png',
		size = 32,
		animations = {
			['propel-down'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['propel-up'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['propel-right'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['propel-left'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
		},
	},
	['mg_shot'] = {
		name = 'Minigun Shot',
		texture = 'gfx/MGShot.png',
		-- TODO: use different frames depending on direction
		speed = 90,
		size = 7,
		animations = {
			['propel-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-up'] = {
				frames = { 2 },
				interval = 0.1,
			},
			['propel-right'] = {
				frames = { 3 },
				interval = 0.1,
			},
			['propel-left'] = {
				frames = { 4 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 5, 6, 7, 8, 9 },
				interval = 0.1,
			},
		},
		sounds = {
			['propel'] = 'sfx/Shot.wav',
		},
	},
	['magma'] = {
		name = 'Magma',
		texture = 'gfx/Magma.png',
		-- TODO: use different frames depending on direction
		size = 26,
		animations = {
			['propel-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-up'] = {
				frames = { 2 },
				interval = 0.1,
			},
			['propel-right'] = {
				frames = { 3 },
				interval = 0.1,
			},
			['propel-left'] = {
				frames = { 4 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
		},
	},
	['head_missile'] = {
		name = 'Head Missile',
		texture = 'gfx/Head Missile.png',
		animations = {
			['idle'] = {
				frames = { 1, 2 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 3, 4, 5, 6, 7 },
				interval = 0.1,
			},
		},
	},
	['fireball'] = {
		name = 'Fireball',
		texture = 'gfx/Fireball.png',
		size = 13,
		animations = {
			['propel-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-up'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-right'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-left'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 2, 3, 4, 5 },
				interval = 0.1,
			},
		},
	},
	['lightbolt'] = {
		name = 'Lightbolt',
		texture = 'gfx/Lightbolt.png',
		size = 13,
		animations = {
			['propel-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-up'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-right'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-left'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 2, 3, 4, 5 },
				interval = 0.1,
			},
		},
	},
	['plasma'] = {
		name = 'Plasma',
		texture = 'gfx/Plasma.png',
		size = 13,
		animations = {
			['propel-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-up'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-right'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['propel-left'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['destroy'] = {
				frames = { 2, 3, 4, 5 },
				interval = 0.1,
			},
		},
	},
	['bomb'] = {
		name = 'Bomb',
		texture = 'gfx/Bomb.png',
		animations = {
			['idle'] = {
				frames = { 1, 2, 3 },
				interval = 0.1,
			},
		},
		sounds = {
			['spawn'] = 'sfx/LightTheFuse.wav',
			['destroy'] = 'sfx/Explosion.wav',
		},
	},
	['explosion'] = {
		name = 'Explosion',
		texture = 'gfx/Explosion.png',
		damage = 1,
		animations = {
			['center'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.05,
			},
			['vertical'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.05,
			},
			['horizontal'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.05,
			},
		},
	},
	['flash'] = {
		name = 'Flash',
		texture = 'gfx/Flash.png',
		animations = {
			['idle'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
		},
		sounds = {
			['spawn'] = 'sfx/Teleport.wav',
		},
	},
	['points1k'] = {
		name = 'Points 10-1K',
		texture = 'gfx/Points 10-1K.png',
		speed = 30,
		sprite_size = { 32, 16 },
		animations = { },
	},
	['points5k'] = {
		name = 'Points 5K',
		texture = 'gfx/Points 5K.png',
		value = 5000,
		speed = 30,
		sprite_size = { 42, 19 },
		animations = { },
	},
	['points100k'] = {
		name = 'Points 100K',
		texture = 'gfx/Points 100K.png',
		value = 100000,
		speed = 30,
		sprite_size = { 75, 28 },
		animations = { },
	},
	['bonus'] = {
		name = 'Bonuses',
		texture = 'gfx/Bonuses.png',
		animations = { },
		sounds = {
			['destroy'] = 'sfx/GetBonus.wav',
		},
	},
	['shield'] = {
		name = 'Shield',
		texture = 'gfx/Shield.png',
		animations = {
			['move-down'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['move-up'] = {
				frames = { 1 },
				interval = 0.1,
			},
			['move-right'] = {
				frames = { 2 },
				interval = 0.1,
			},
			['move-left'] = {
				frames = { 3 },
				interval = 0.1,
			},
		},
	},
}
