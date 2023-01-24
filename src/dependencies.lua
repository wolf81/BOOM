Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
Gamestate = require 'lib.hump.gamestate'
-- anim8 = require 'lib.anim8.anim8'

require 'src.constants'

require 'src.level'
require 'src.level_loader'
require 'src.transition'

require 'src.scene.scene_base'
require 'src.scene.loading'
require 'src.scene.game'

require 'src.entity.entity_base'
require 'src.entity.breakable_block'
require 'src.entity.fixed_block'
require 'src.entity.teleporter'
require 'src.entity.monster'
require 'src.entity.player'
require 'src.entity.coin'
