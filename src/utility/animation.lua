--[[
--  BOOM
--  Copyright (c) 2023 Wolftrail Ltd
--  Author: Wolfgang Schreurs
--  Email: info+boom@wolftrail.net
--]]

local math_max, table_insert = math.max, table.insert

Animation = Class {}

function Animation:init(def)
    self.frames = def.frames

    local times = def.times or 1
    
    local frames = CopyTable(self.frames)
    while times > 1 do
        for _, frame in ipairs(frames) do
            table_insert(self.frames, frame)
        end
        times = times - 1
    end

    self.interval = def.interval
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
	if #self.frames == 1 then return end

    self.timer = self.timer + dt
    if self.timer > self.interval then
        self.timer = self.timer % self.interval
        self.currentFrame = math_max(1, (self.currentFrame + 1) % (#self.frames + 1))
    end
end

function Animation:getDuration()
    return #self.frames * self.interval
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end
