Propel = State:extend()

function Propel:enter(params)
	Propel.super.enter(self, params)
end

function Propel:update(dt)
	Propel.super.update(self, dt)

	local entity = self.entity

	local gridPos = entity:gridPosition()
	local dxy = entity:velocity():permul(TileSize) * dt * entity:speed()
	local pos = entity:position() + dxy
	entity:setPosition(pos)

	--[[
		-1
	-1	 0	 1
		 1
	]]

	local toGridPos = entity:gridPosition()
	if entity:level():isBlocked(toGridPos) then
		local offset = entity:velocity():permul(vector(-TileSize.x, -TileSize.y))
		local toPos = toPosition(toGridPos) + offset
		entity:setPosition(toPos)
		entity:destroy()
	end
end

function Propel:draw()
	Propel.super.draw(self)
end