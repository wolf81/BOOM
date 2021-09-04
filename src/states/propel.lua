Propel = State:extend()

function Propel:enter(params)
	Propel.super.enter(self, params)
end

function Propel:update(dt)
	Propel.super.update(self, dt)

	local entity = self.entity
	local dxy = entity:velocity():permul(TileSize) * dt * entity:speed()
	local pos = entity:position() + dxy
	entity:setPosition(pos)
end

function Propel:draw()
	Propel.super.draw(self)
end