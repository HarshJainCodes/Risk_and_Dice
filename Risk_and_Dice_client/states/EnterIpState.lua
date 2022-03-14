EnterIpState = Class{__includes = BaseState}

-- this lets us remove the letter form the word if we press backspace


local textbox = {} -- to receive the ip from the user
textbox.width = 250
textbox.height = 45
textbox.x = WINDOW_WIDTH/2 - textbox.width/2
textbox.y = WINDOW_HEIGHT/2 - textbox.height/2
textbox.text = ""

function EnterIpState:init()
    -- background = love.graphics.newImage("assets/HomePage.png")
end

function EnterIpState:enter()
    
end

function EnterIpState:mousepressed(x, y)
    
end

function EnterIpState:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "backspace" then
        local byteoffset = utf.offset(textbox.text, -1)
        if byteoffset then
            textbox.text = string.sub(textbox.text, 1, byteoffset - 1)
        end
    elseif key == "return" then
        gStateMachine:change("enterport", textbox.text)
    end
end

function EnterIpState:textinput(t)
    textbox.text = textbox.text..t
end

function EnterIpState:update(dt)
    
end

function EnterIpState:render()
    love.graphics.draw(background, 0, 0, 0, WINDOW_WIDTH/background:getWidth(), WINDOW_HEIGHT/background:getHeight())
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.printf("enter the ip", 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, "center")
    love.graphics.rectangle("line", textbox.x, textbox.y, textbox.width, textbox.height, 20, 20)
    love.graphics.printf(textbox.text, textbox.x, textbox.y + 3, textbox.width, "center")
end

function EnterIpState:exit()
    
end