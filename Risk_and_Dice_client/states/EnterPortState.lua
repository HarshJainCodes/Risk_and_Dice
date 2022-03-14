EnterPortState = Class{__includes = BaseState}

local textbox = {} -- to receive the ip from the user
textbox.width = 200
textbox.height = 45
textbox.x = WINDOW_WIDTH/2 - textbox.width/2
textbox.y = WINDOW_HEIGHT/2 - textbox.height/2
textbox.text = ""

function EnterPortState:init()
    
end

function EnterPortState:enter(ipaddress)
    IPADDRESS = ipaddress
end

function EnterPortState:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "backspace" then
        local byteoffset = utf.offset(textbox.text, -1)
        if byteoffset then
            textbox.text = string.sub(textbox.text, 1, byteoffset - 1)
        end
    elseif key == "return" then
        PORT = tonumber(textbox.text)
        --gStateMachine:change("play", {self.ipaddress, textbox.text})
        gStateMachine:change("instructions")
    end
end

function EnterPortState:textinput(t)
    textbox.text = textbox.text..t
end

function EnterPortState:update(dt)
    
end

function EnterPortState:render()
    love.graphics.draw(background, 0, 0, 0, WINDOW_WIDTH/background:getWidth(), WINDOW_HEIGHT/background:getHeight())
    love.graphics.printf("enter the port number : ", 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, "center")
    love.graphics.rectangle("line", textbox.x, textbox.y, textbox.width, textbox.height, 20, 20)
    love.graphics.printf(textbox.text, textbox.x, textbox.y + 3, textbox.width, "center")
end