EntityBase = Class {}

function EntityBase:init(def)
	self.x = def.x
	self.y = def.y

	self.image = ImageCache.load(def.texture)

	self.anim_grid = anim8.newGrid(TILE_W, TILE_H, self.image:getWidth(), self.image:getHeight())

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')
end

function EntityBase:update(dt)
	self.state_machine:update(dt)
end

function EntityBase:changeState(name, ...)
	self.state_machine:change(name, ...)
end

function EntityBase:draw()
	self.state_machine:draw()
end
