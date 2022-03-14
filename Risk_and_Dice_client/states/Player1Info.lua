Player1Info = Class{}

local textbox = {}
textbox.width = 300
textbox.height = 40
textbox.x = WINDOW_WIDTH/2 - textbox.width/2
textbox.y = WINDOW_HEIGHT/2 - textbox.height/2
textbox.text = ""

local next_button = {}
next_button.width = 300
next_button.height = 40
next_button.x = WINDOW_WIDTH/2 - next_button.width/2
next_button.y = WINDOW_HEIGHT/2 - next_button.height + 100

function Player1Info:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "backspace" then
        local byteoffset = utf.offset(textbox.text, -1)
        if byteoffset then
            textbox.text = string.sub(textbox.text, 1, byteoffset - 1)
        end
    end
end


function Player1Info:enter(mode)
    self.mode = mode
end

function Player1Info:mousepressed(x, y)
    if x > next_button.x and x < next_button.x + next_button.width and y > next_button.y and y < next_button.y + next_button.height then
        if self.mode == "offline" then
            gStateMachine:change("Player2Info", textbox.text)
        else
            gStateMachine:change("play", {IPADDRESS, PORT, textbox.text})
        end
        
    end
end

function Player1Info:textinput(t)
    textbox.text = textbox.text..t
end

function Player1Info:init() 
    self.background = love.graphics.newImage("assets/background.png")
end

function Player1Info:exit() 

end

function Player1Info:update(dt) 

end

function Player1Info:render() 
    love.graphics.draw(self.background, 0, 0 ,0, WINDOW_WIDTH/self.background:getWidth(), WINDOW_HEIGHT/self.background:getHeight())
    --love.keyboard.setTextInput(true)
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.printf("Enter Player 1 name", 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, "center")
    love.graphics.rectangle("line", textbox.x, textbox.y, textbox.width, textbox.height, 20, 20)
    love.graphics.printf(textbox.text, textbox.x, textbox.y , textbox.width, "center")
    love.graphics.printf(textbox.text, textbox.x, textbox.y - 160, textbox.width, "center")
    love.graphics.rectangle("line", next_button.x, next_button.y, next_button.width, next_button.height, 20, 20)
    love.graphics.printf("next", next_button.x, next_button.y, next_button.width, "center")
end