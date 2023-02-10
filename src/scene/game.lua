--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

Game = Class { __includes = SceneBase }

local level_str = nil

local function generateBackground()
	local canvas = love.graphics.newCanvas(WINDOW_W - HUD_W, WINDOW_H)

	canvas:renderTo(function()
		love.graphics.setCanvas(canvas)
		love.graphics.clear(0.0, 0.0, 0.0, 0.0)
	end)

	return canvas
end

local function proceedNextLevel(self)
	self.accept_input = false
	local level, background = LevelLoader.load(self.level.index + 1)
	if level then
		Transition.crossfade(self, Game, level, background)
	else
		Transition.crossfade(self, Loading, 1)
	end
end

function Game:init()
	SceneBase.init(self)

	self.background = generateBackground()
end

function Game:enter(previous, level, background)
	self.level = level
	self.background = background
	self.hud = Hud(self.level)

	bitser.registerClass('hump.vector', getmetatable(vector()), nil, setmetatable)
	bitser.registerClass('hump.timer', getmetatable(Timer()), nil, setmetatable)
	bitser.registerClass('baton', getmetatable(baton.new({ controls = {} })), nil, setmetatable)

	bitser.registerClass('StateBase', StateBase)
	bitser.registerClass('Move', Move)
	bitser.registerClass('Idle', Idle)
	bitser.registerClass('Destroy', Destroy)
	bitser.registerClass('Hit', Hit)
	bitser.registerClass('Attack', Attack)
	bitser.registerClass('Propel', Propel)

	bitser.registerClass('StateMachine', StateMachine)
	local s = StateMachine()
	bitser.register('StateMachine.empty', s.empty)
	bitser.register('StateMachine.states', s.states)
	bitser.register('StateMachine.current', s.current)
	local t = bitser.dumps(s)
	print(t)

	bitser.registerClass('Animation', Animation)
	bitser.registerClass('Grid', Grid)

	bitser.registerClass('EntityBase', EntityBase)
	bitser.registerClass('Creature', Creature)
	bitser.registerClass('Player', Player)

	bitser.registerClass('PlayerControl', PlayerControl)
	bitser.registerClass('CpuControl', CpuControl)
end

function Game:onFinishTransition()
	self.accept_input = true
end

function Game:update(dt)
	self.hud:update(dt)
	self.level:update(dt)
end

function Game:draw()
	self.hud:draw()

	love.graphics.push()
	love.graphics.translate(HUD_W, 0)
	love.graphics.draw(self.background)
	self.level:draw()
	love.graphics.pop()
end

function Game:keyreleased(key, code)
	if not self.accept_input then return end

    if key == 'f1' then proceedNextLevel(self)
    elseif key == 'f2' then self.level:destroyBlocks()
    elseif key == 'f5' then
    	local player = EntityBase({ name = 'test', animations = {} })
    	-- local player = CopyTable(self.level.fixed_blocks[1])
    	-- player.level = nil
    	player:config(1, 0, 0)

    	-- for k,v in pairs(player.state_machine.states) do
    	-- 	bitser.register(k, v)
    	-- end

    	-- bitser.register('player.state_machine', player.state_machine)

    	PrintTable(player)

    	-- local s = StateMachine({ ['idle'] = function() return Idle() end })
    	-- local t = bitser.dumps(s)
    	-- print(t)

    	-- print(lume.serialize(player))
    	local x = bitser.dumps(player)
    	print(x)
    end
end
