CpuControl = {}
CpuControl.__index = CpuControl

function CpuControl:new(monster)
	return setmetatable({
		_monster = monster,
	}, self)
end

function CpuControl:update(dt)
	-- body
end

return setmetatable(CpuControl, {
	__call = CpuControl.new
})

