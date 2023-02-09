--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Class = require 'lib.hump.class'
Timer = require 'lib.hump.timer'
vector = require 'lib.hump.vector'
lume = require 'lib.lume.lume'
binser = require "lib.binser.binser"

require 'src.constants'
require 'src.direction'

require 'src.level'

require 'src.ui.hud'
require 'src.ui.health_bar'
require 'src.ui.extra_bar'
require 'src.ui.bonus_bar'
require 'src.ui.score_view'
require 'src.ui.time_view'
require 'src.ui.player_view'

require 'src.utility.level_loader'
require 'src.utility.transition'
require 'src.utility.image_cache'
require 'src.utility.audio_player'
require 'src.utility.state_machine'
require 'src.utility.functions'
require 'src.utility.animation'
require 'src.utility.grid'
require 'src.utility.entity_factory'

require 'src.control.player_control'
require 'src.control.cpu_control'

require 'src.scene.scene_base'
require 'src.scene.loading'
require 'src.scene.game'

require 'src.state.state_base'
require 'src.state.idle'
require 'src.state.move'
require 'src.state.destroy'
require 'src.state.attack'
require 'src.state.propel'
require 'src.state.hit'

require 'src.entity.entity_base'
require 'src.entity.block'
require 'src.entity.flash'
require 'src.entity.bomb'
require 'src.entity.breakable_block'
require 'src.entity.teleporter'
require 'src.entity.projectile'
require 'src.entity.explosion'
require 'src.entity.creature'
require 'src.entity.monster'
require 'src.entity.player'
require 'src.entity.coin'
require 'src.entity.points'
require 'src.entity.points_1k'
require 'src.entity.points_5k'
require 'src.entity.points_100k'
require 'src.entity.bonus'
require 'src.entity.extra'
require 'src.entity.shield'

require 'src.overlay'
