PlayState = Class{__includes = BaseState}
pipeSpeed = 60
pipeWidth = 70
pipeHeight = 288
birdWidth = 38
birdHeight = 24

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0
    self.score = 0
    self.interval = 2
    self.lastY = -pipeHeight + math.random(80) + 20
    self.pause = false
end

function PlayState:update(dt)
    if self.pause == false then
        self.timer = self.timer + dt
    if self.timer > self.interval then
        local y = math.max(-pipeHeight + 10, math.min(self.lastY + math.random(-20,20), 
        v_height - 90 - pipeHeight))
        self.lastY = y
        table.insert(self.pipePairs, PipePair(y))
        self.timer = 0
        self.interval = math.random(2,5)
    end

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + pipeWidth < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                sounds['score']:play()
            end
        end
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    self.bird:update(dt)
    
    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                sounds['explosion']:play()
                sounds['hurt']:play()
                gStateMachine:change('score', {
                    score = self.score })
            end
        end
    end

    if self.bird.y > v_height - 15 then
        gStateMachine:change('score', {
            score = self.score
        })
    end
    if love.keyboard.wasPressed('p') then
        self.pause = true
        scrolling = false
        self.bird.y = self.bird.y
        sounds['music']:stop()
        sounds['pause']:play()
    end
    else
        if love.keyboard.wasPressed('p') then
            self.pause = false
            scrolling = true
            sounds['music']:setLooping(true)
            sounds['music']:play()
            sounds['pause']:play()
        end
    end
end

function PlayState:render()
    if self.pause == true then

        for k, pair in pairs(self.pipePairs) do
            pair:render()
        end
    self.bird:render()
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    love.graphics.printf('Paused', 0, 64, v_width, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.draw(love.graphics.newImage('sprites/pause.png'), v_width / 2 - 8, 120)
    else
        for k, pair in pairs(self.pipePairs) do
            pair:render()
        end
    self.bird:render()
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    end
end

function PlayState:enter()
    scrolling = true
end

function PlayState:exit()
    scrolling = false
end