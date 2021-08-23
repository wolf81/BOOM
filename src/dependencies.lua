-- dependencies
Object = require 'lib/classic/classic'
json = require 'lib/json/json'
anim8 = require 'lib/anim8/anim8'
vector = require 'lib/hump/vector'

-- utilities
GridGraph = require 'src/utilities/gridgraph'
Background = require 'src/utilities/background'
DataLoader = require 'src/utilities/dataloader'
EntityFactory = require 'src/utilities/entityfactory'
require 'src/utilities/Animation'
require 'src/utilities/statemachine'

-- states
require 'src/states/idle'
require 'src/states/attack'

-- entities
require 'src/entities/entity'
require 'src/entities/player'
require 'src/entities/monster'
require 'src/entities/block'

-- game
require 'src/constants'
require 'src/map'
require 'src/level'
