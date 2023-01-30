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
		animations = {
			['destroy'] = {
				frames = { 2, 3, 4 },
				interval = 0.1,
			},
		},
	},
	['3'] = {
		name = 'Coin',
		texture = 'gfx/Coin.png',
		animations = {
			['destroy'] = {
				frames = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
				interval = 0.025,				
			},
		},
	},
	['A'] = {
		name = 'Soldier',
		description = 'This only apparently human creature is pretty stupid. Moves erratically. Almost harmless.',
		texture = 'gfx/Soldier.png',
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
				interval = 0.1,
			},
		},
	},
	['B'] = {
		name = 'Sgt. Cool',
		description = 'He\'s tough, he\'s mean, he wears shades. In fact, the only difference with the soldier is a slightly higher fire rate.',
		texture = 'gfx/Sarge.png',
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
				interval = 0.1,
			},
		},
	},
	['C'] = {
		name = 'Thick Lizzy',
		description = 'Part man, part reptile, all nastiness. This ugly beast casts deadly fireballs.',
		texture = 'gfx/Lizzy.png',
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
				frames = { 21, 22, 23, 24 },
				interval = 0.1,
			},
		},
	},
	['D'] = {
		name = 'Mean-o-Taur',
		description = 'A sort of a cross between a man and a bull on steroids. Fast and extremely vicious.',
		speed = 2.0,
		texture = 'gfx/Taur.png',
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
				interval = 0.1,
			},			
		},
	},	
	['E'] = {
		name = 'Gunner',
		description = 'Another former human being. He holds a rapid-fire pulse rifle. Veeery dangerous!',
		texture = 'gfx/Gunner.png',
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
				interval = 0.1,
			},
		},
	},
	['F'] = {
		name = 'The \"Thing\"',
		description = 'The aliens\' favorite pet. Luckily our dogs don\'t spit energy bolts.',
		texture = 'gfx/Thing.png',
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
				interval = 0.1,
			},
		},
	},
	['G'] = {
		name = 'Ghost',
		description = 'This creature from beyond is unarmed but his fast and incessant attacks can be very annoying.',
		speed = 2.5,
		texture = 'gfx/Ghost.png',
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
				interval = 0.1,
			},
		},
	},
	['H'] = {
		name = 'Smoulder',
		description = 'A fat and ugly psycho killer. Keep away from his lethal flamethrower if you want to survive.',
		texture = 'gfx/Smoulder.png',
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
				frames = { 21, 22, 23, 24 },
				interval = 0.1,
			},
		},
	},
	['I'] = {
		name = 'Skully',
		description = 'A biomechanical creature. Its plasma cannon will wipe you out in seconds.',
		texture = 'gfx/Skully.png',
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
				interval = 0.1,
			},
		},
	},
	['J'] = {
		name = 'H.R. Giggler',
		description = 'Your worst nightmare. The ultimate biological weapon. Throws radioactive magma and runs like a demon.',
		texture = 'gfx/Giggler.png',
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
				interval = 0.1,
			},
		},
	},
	['X'] = {
		name = 'Player 1',
		texture = 'gfx/Player1.png',
		speed = 2.0,
		fuse_time = 3.0,
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
				interval = 0.1,
			},
		},
	},
	['Y'] = {
		name = 'Player 2',
		texture = 'gfx/Player2.png',
		speed = 2.0,
		fuse_time = 3.0,
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
				interval = 0.1,
			},
		},
	},	
	['*'] = {
		name = 'Head Boss',
		texture = 'gfx/Head Boss.png',
		size = { 96, 96 },
		animations = {
			['destroy'] = {
				frames = { 1 },
				interval = 0.1,
			},			
		},
	},	
	['alien-boss'] = {
		name = 'Alien Boss',
		texture = 'gfx/Alien Boss.png',
		size = { 160, 160 },
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
				interval = 0.1,
			},			
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
	['bomb'] = {
		name = 'Bomb',
		texture = 'gfx/Bomb.png',
		animations = {
			['idle'] = {
				frames = { 1, 2, 3 },
				interval = 0.1,
			},
		},
	},
	['explosion'] = {
		name = 'Explosion',
		texture = 'gfx/Explosion.png',
		animations = {
			['center'] = {
				frames = { 1, 2, 3, 4 },
				interval = 0.1,
			},
			['vertical'] = {
				frames = { 5, 6, 7, 8 },
				interval = 0.1,
			},
			['horizontal'] = {
				frames = { 9, 10, 11, 12 },
				interval = 0.1,
			},
		}
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
	},
}
