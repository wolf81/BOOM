--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max = math.max

Bomb = Class { __includes = EntityBase }

function Bomb:init(def)
	EntityBase.init(self, def)

	self.z_index = 1
end

function Bomb:config(id, x, y, player)
	EntityBase.config(self, id, x, y)

	assert(player ~= nil and getmetatable(player) == Player, 'player is required')

	self.player = player
	self.fuse_time = self.player.fuse_time
	self.size = 2
end

function Bomb:explode()
	self.fuse_time = 0
end

function Bomb:update(dt)
	EntityBase.update(self, dt)

	self.fuse_time = math_max(self.fuse_time - dt, 0)
	if self.fuse_time == 0 then
		self.level:addEntity(EntityFactory.create('explosion', self.pos.x, self.pos.y, self.player, Direction.NONE))
		self.level:removeEntity(self)		

		local grid_pos = self:gridPosition()

		for _, dir in ipairs({ Direction.UP, Direction.DOWN, Direction.LEFT, Direction.RIGHT }) do
			for i = 1, self.size do
				local next_grid_pos = grid_pos + dir * i

				if self.level:isBlocked(next_grid_pos.x, next_grid_pos.y) then 
					if i > 1 then break end

					local bblock = self.level:getBreakableBlock(next_grid_pos)
					if bblock then
						local pos = (grid_pos + dir * i):permul(TILE_SIZE)
						self.level:addEntity(EntityFactory.create('explosion', pos.x, pos.y, self.player, dir))

						bblock:destroy()
					end

					break
				end

				local bomb = self.level:getBomb(next_grid_pos)
				if bomb then bomb:explode() end

				local pos = (next_grid_pos):permul(TILE_SIZE)
				self.level:addEntity(EntityFactory.create('explosion', pos.x, pos.y, self.player, dir))				
			end
		end
	end
end
