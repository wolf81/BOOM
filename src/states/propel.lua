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

	local gridPos = entity:gridPosition()
	if entity:level():isBlocked(gridPos) then
		local size = entity:size()
		local offset = entity:velocity():permul(-TileSize / 2) + vector(0, size.y)
		local toPos = toPosition(gridPos) + offset
		entity:setPosition(toPos)
		entity:destroy()
	end
end

function Propel:draw()
	Propel.super.draw(self)
end