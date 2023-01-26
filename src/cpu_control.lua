local math_floor = math.floor

CpuControl = Class {}

function CpuControl:init(entity)
	self.entity = entity
end

function CpuControl:update(dt)	
	if self.entity.pos.y % TILE_H == 0 and self.entity.pos.x % TILE_W == 0 then
		local dirs = lume.shuffle({
			Direction.UP, 
			Direction.DOWN, 
			Direction.LEFT, 
			Direction.RIGHT
		})

		local dir = Direction.NONE

		while #dirs > 0 do
			local direction = table.remove(dirs)
			local to_x = math_floor(self.entity.pos.x / TILE_W + 0.5) + direction.x
			local to_y = math_floor(self.entity.pos.y / TILE_H + 0.5) + direction.y

			if not self.entity.level:isBlocked(to_x, to_y) then
				dir = direction
				break
			end
		end

		self.entity:move(dir)
	end
end