Player = Class { __includes = EntityBase }

function Player:init(def)
	EntityBase.init(self, def)

	self.state_machine = StateMachine {
		['idle'] = function() return Idle(self) end,
		['move'] = function() return Move(self) end,
	}
	self.state_machine:change('idle')	
end

function Player:update(dt)
	EntityBase.update(self, dt)

	self.state_machine:update(dt)
end

function Player:changeState(name, ...)
	self.state_machine:change(name, ...)
end
