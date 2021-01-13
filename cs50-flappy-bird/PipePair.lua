PipePair = Class{}

function PipePair:init(y)
    local gapHeight = math.random(75, 100)
    self.scored = false
    self.x = v_width + 32
    self.y = y
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + pipeHeight + gapHeight)
    }
    self.remove = false
end

function PipePair:update(dt)
    if self.x > -pipeWidth then
        self.x = self.x - pipeSpeed * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for l, pipe in pairs(self.pipes) do
        pipe:render()
    end
end