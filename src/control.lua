Control = Class {}

function Control:init(entity)
	self.entity = entity
end

function Control:update(dt)	
	local direction = Direction.none

	-- if vertically aligned with tiles, allow movement in horizontal directions
	if self.entity.pos.y % TILE_H == 0 then
		if love.keyboard.isDown('left') then direction = Direction.left
		elseif love.keyboard.isDown('right') then direction = Direction.right
		end
	end

	-- if horizontally aligned with tiles, allow movement in vertical directions
	if self.entity.pos.x % TILE_W == 0 then
		if love.keyboard.isDown('up') then direction = Direction.up
		elseif love.keyboard.isDown('down') then direction = Direction.down
		end
	end

	if direction ~= Direction.none then
		self.entity:move(direction)
	else
		-- if direction is none, don't stop immediately, but make entity stop moving when 
		-- reaching target position for current move
		self.entity.direction = Direction.none
	end
end
