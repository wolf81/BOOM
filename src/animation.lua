local mmax = math.max

Animation = Class {}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
	if #self.frames == 1 then return end

    self.timer = self.timer + dt
    if self.timer > self.interval then
        self.timer = self.timer % self.interval
        self.currentFrame = mmax(1, (self.currentFrame + 1) % (#self.frames + 1))
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end
