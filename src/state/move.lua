Move = Class { __includes = StateBase }

function Move:enter(direction)
	StateBase.enter(self, entity)
end

function Move:update(dt)
	-- body
end
