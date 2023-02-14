--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_min, math_random, table_insert, table_remove = math.min, math.random, table.insert, table.remove

Boss = Class { __includes = Creature }

local function configureStateMachine(self)
	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['destroy'] = function() return Destroy(self) end,
		['hit'] = function() return Hit(self) end,
		['attack'] = function() return Attack(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')
end

function Boss:init(def)
	Creature.init(self, def)

	local attack_info = def.attack or {}
	attack_info.rate = attack_info.rate or 0.0
	self.attack_rate = attack_info.rate
	self.projectile = attack_info.projectile
end

function Boss:config(id, x, y)
	Creature.config(self, id, x, y)

	-- TODO: should clean up hitlist
	-- one approach could be to store time of hit and on update delete all hits caused longer than 1 second ago
	-- another approach could be to notify the boss that a bomb is destroyed, however explosions are destroyed
	-- slightly later than bomb, so again a delay would be needed
	self.hit_list = {}
	self.explode_list = {}
end

function Boss:update(dt)
	Creature.update(self, dt)

	local time = love.timer.getTime()
	while #self.explode_list > 0 do
		local explode_info = table_remove(self.explode_list, 1)

		if explode_info.time < time then
			self.level:addEntity(explode_info.explosion)
			explode_info.explosion:destroy()
		else
			table_insert(self.explode_list, 1, explode_info)
			break
		end
	end
end

function Boss:serialize()
	local obj = Creature.serialize(self)
	obj.hit_list = self.hit_list
	obj.explode_list = self.explode_list
	return obj
end

function Boss.deserialize(obj)
	local boss = Creature.deserialize(obj)
	boss.hit_list = obj.hit_list
	boss.explode_list = obj.explode_list
	return boss
end

function Boss:hit(entity)
	if entity:is(Explosion) then
		if not self.hit_list[entity.bomb_id] then
			self.hit_list[entity.bomb_id] = true
			Creature.hit(self, entity)
		end
	else
		Creature.hit(self, entity)
	end
end

function Boss:destroy()
	if not self:isDestroyed() then
		for t = 0, 20 do
			local x = self.pos.x + math_random(0, self.size.x - TILE_W)
			local y = self.pos.y + math_random(0, self.size.y - TILE_H)
			local time = love.timer.getTime()
			local explosion = EntityFactory.create('head-missile', x, y, Direction.DOWN)
			table_insert(self.explode_list, { explosion = explosion, time = time + t * 0.25 })
		end
	end

	Creature.destroy(self)
end

function Boss:canAttack() return
	false
end
