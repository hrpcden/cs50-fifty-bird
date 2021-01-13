ScoreState = Class{__includes = BaseState}

function ScoreState:init()

end

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, v_width, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, v_width, 'center')
    
    if self.score > 0 then
         if self.score < 6 then
            love.graphics.draw(love.graphics.newImage('sprites/ribbon_01_red.png'), v_width/2 - 23, 120)
    elseif self.score < 11 then
        love.graphics.draw(love.graphics.newImage('sprites/ribbon_01_blue.png'), v_width/2 - 23, 120)
    elseif self.score < 21 then
        love.graphics.draw(love.graphics.newImage('sprites/medal_02_bronze.png'), v_width/2 - 23, 120)
    elseif self.score < 26 then
        love.graphics.draw(love.graphics.newImage('sprites/medal_02_silver.png'), v_width/2 - 23, 120)
    elseif self.score < 31 then
        love.graphics.draw(love.graphics.newImage('sprites/medal_02_gold.png'), v_width/2 - 23, 120)
    elseif self.score < 36 then
        love.graphics.draw(love.graphics.newImage('sprites/trophy_03_bronze.png'), v_width/2 - 23, 120)
    elseif self.score < 41 then
        love.graphics.draw(love.graphics.newImage('sprites/trophy_03_silver.png'), v_width/2 - 23, 120)
    elseif self.score < 56 then
        love.graphics.draw(love.graphics.newImage('sprites/trophy_03_gold.png'), v_width/2 - 23, 120)
    elseif self.score < 100 then
        love.graphics.draw(love.graphics.newImage('sprites/medal_03.png'), v_width/2 - 23, 120) 
    end
    end
    love.graphics.printf('Press Enter to Play Again!', 0, 160, v_width, 'center')
end