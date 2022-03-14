-- the client file of the risk and dice online

-- dimentions of the window

WINDOW_WIDTH = 1200
WINDOW_HEIGHT = 600

-- require class to use OOP
Class = require "class"

-- require push to adjust to different screens
push = require "push"

-- bitser to do serialisation otherwise program wont work
-- just serialises the data nothing to learn about this library
bitser = require "bitser"

-- sockets library to make client and server objects
-- way more convinient then the standard sockets
sock = require "sock"

-- we do need to require this to get the ip of the server if you want to play using mobile hotspot
socket = require "socket"

-- manages the states
require "StateMachine"

-- to add backspace functionality on love.textinput
utf = require "utf8"

-- require our states
require "states/BaseState"
require "states/HomePage"
require "states/EnterIpState"
require "states/EnterPortState"
require "states/InstructionsState"
require "states/PlayState"
require "states/Player1Info"
require "states/Player2Info"
require "states/offline_mode"


function love.load()
    --love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        stretched = false
    })

    gStateMachine = StateMachine{
        ["HomePage"] = function () return HomePage() end,
        ["enterip"] = function () return EnterIpState() end,
        ["enterport"] = function () return EnterPortState() end,
        ["play"] = function () return PlayState() end,
        ["instructions"] = function () return InstructionsState() end,
        ["Player1Info"] = function () return Player1Info() end,
        ["Player2Info"] = function () return Player2Info() end,
        ["offline_mode"] = function () return Offline_game() end
    }
    gStateMachine:change("HomePage")
end

function love.mousepressed(x1, y1)
    x, y = push:toGame(x1, y1)
    gStateMachine.current:mousepressed(x, y)
end

function love.resize(w, h)
    push:resize(w, h)
    
end

function love.keypressed(key)
    gStateMachine.current:keypressed(key)
end

function love.textinput(t)
    gStateMachine.current:textinput(t)
    
end

function love.update(dt)
    gStateMachine:update(dt)
end

function love.draw()
    push:start()
    gStateMachine:render()
    love.graphics.printf(tostring(love.timer.getFPS()), 0, 0, WINDOW_WIDTH, "center")
    push:finish()
end