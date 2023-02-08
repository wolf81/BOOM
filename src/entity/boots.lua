Boots = Class { __includes = EntityBase }

function Boots:config(id, x, y, player, duration)
	EntityBase.config(self, id, x, y)

	assert(player ~= nil, 'player is required')
	assert(duration ~= nil and type(duration) == 'number', 'duration is required')

	self.duration = duration
	self.player = player
end

function Boots:update(dt)
	EntityBase.update(self, dt)

	self.duration = math_max(self.duration - dt, 0)
	if self.duration <= 1.5 then
		if math_floor(self.duration * 10) % 2 == 0 then
			self.player:setBootsExpiring(true)
		else
			self.player:setBootsExpiring(false)
		end
	end
end

function Boots:draw()
	--
end
