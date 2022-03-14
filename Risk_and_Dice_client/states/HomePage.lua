HomePage = Class{__includes = HomePage}


function HomePage:init() 
    background = love.graphics.newImage("assets/HomePage.png")
    offline_img = love.graphics.newImage("assets/offline.png")
    online_img = love.graphics.newImage("assets/online.png")
end

local offline_button = {}
offline_button.width = 100
offline_button.height = 80
offline_button.x = WINDOW_WIDTH/3 - offline_button.width/2
offline_button.y = WINDOW_HEIGHT - 100 - offline_button.height/2

local online_button = {}
online_button.width = 100
online_button.height = 80
online_button.x = 2 * WINDOW_WIDTH/3 - offline_button.width/2
online_button.y = WINDOW_HEIGHT - 100 - offline_button.height/2

function HomePage:enter()

end

function HomePage:keypressed(key)
    
end

function HomePage:mousepressed(x, y)
    if x > online_button.x and x < online_button.x + online_button.width and y > online_button.y and y < online_button.y + online_button.height then
        gStateMachine:change("enterip")
    end
    if x > offline_button.x and x < offline_button.x + offline_button.width and y > offline_button.y and y < offline_button.y + offline_button.height then
        gStateMachine:change("Player1Info", "offline")
    end
end

function HomePage:exit()

end

function HomePage:update(dt)

end

function HomePage:render()
    love.graphics.draw(background, 0, 0, 0, WINDOW_WIDTH/background:getWidth(), WINDOW_HEIGHT/background:getHeight())
    love.graphics.draw(offline_img, offline_button.x, offline_button.y, 0, offline_button.width/offline_img:getWidth(), offline_button.height/offline_img:getHeight())
    love.graphics.draw(online_img, online_button.x, online_button.y, 0, online_button.width/online_img:getWidth(), online_button.height/online_img:getHeight())
end