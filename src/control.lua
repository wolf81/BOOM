Control = Class {}

function Control:init(entity)
	self.entity = entity
end

function Control:update(dt)
	if love.keyboard.isDown('up') then
		self.entity:changeState('move', Direction.up)
	elseif love.keyboard.isDown('down') then
		self.entity:changeState('move', Direction.down)
	elseif love.keyboard.isDown('left') then
		self.entity:changeState('move', Direction.left)
	elseif love.keyboard.isDown('right') then
		self.entity:changeState('move', Direction.right)
	else
		self.entity:changeState('idle') 
	end
end
