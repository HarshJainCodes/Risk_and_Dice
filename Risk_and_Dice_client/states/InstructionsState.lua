InstructionsState = Class{}

function InstructionsState:init()
    self.instructionsImage = love.graphics.newImage("assets/Instructions.png")
end

function InstructionsState:enter()
    
end

function InstructionsState:update(dt)
    
end

local play_button = {}
play_button.width = 100
play_button.height = 50
play_button.x = WINDOW_WIDTH/2 - play_button.width/2
play_button.y = 525

function InstructionsState:mousepressed(x, y)
    if x > play_button.x and x < play_button.x + play_button.width and y > play_button.y and y < play_button.y + play_button.height then
        --gStateMachine:change("play", {IPADDRESS, PORT})
        gStateMachine:change("Player1Info")
    end
end

function InstructionsState:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function InstructionsState:render()
    love.graphics.draw(self.instructionsImage, 0, 0, 0, WINDOW_WIDTH/self.instructionsImage:getWidth(), WINDOW_HEIGHT/self.instructionsImage:getHeight())
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.printf("play", play_button.x, play_button.y, play_button.width, "center")
    love.graphics.rectangle("line", play_button.x, play_button.y, play_button.width, play_button.height, 20, 20)
end

function InstructionsState:exit()
    
end