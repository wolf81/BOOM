--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, bit_band, bit_rshift = math.max, bit.band, bit.rshift

Bomb = Class { __includes = EntityBase }

function Bomb:config(id, x, y, player, fn)
	EntityBase.config(self, id, x, y)

	assert(player ~= nil and getmetatable(player) == Player, 'player is required')

	self.player = player
	self.fuse_time = self.player:getFuseDuration()
	self.size = 2 + self.player:getExplodeRange()

	self.onDestroy = fn or function() end
end

function Bomb:explode()
	self.fuse_time = 0
end

function Bomb:destroy()
	if not self:isDestroyed() then
		self.onDestroy(self)
	end

	EntityBase.destroy(self)
end

function Bomb:update(dt)
	self.fuse_time = math_max(self.fuse_time - dt, 0)

	-- double animation speed when bombs are about to explode
	if self.fuse_time < 1.5 then dt = dt * 2 end

	EntityBase.update(self, dt)

	if self.fuse_time == 0 then
		self.level:addEntity(EntityFactory.create('explosion', self.pos.x, self.pos.y, self.player))
		self:destroy()

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
