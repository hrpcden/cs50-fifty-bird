Pipe  = Class{}

local pipeImage = love.graphics.newImage('pipe.png')
pipeSpeed = 60
pipeHeight = 430
pipeWidth = 70


function Pipe:init(orientation, y)
    self.x = v_width
    self.y = y
    self.width = pipeWidth
    self.height = pipeHeight
    self.orientation = orientation
end

function Pipe:update(dt)

end

function Pipe:render()
    love.graphics.draw(pipeImage, self.x, 
        (self.orientation == 'top' and self.y + pipeHeight or self.y), 0, 1, 
        self.orientation == 'top' and self.y -1 or 1)
end