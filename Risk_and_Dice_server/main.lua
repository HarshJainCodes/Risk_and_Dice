-- the server file of the risk and dice online

-- dimentions of the window
WINDOW_WIDTH = 400
WINODW_HEIGHT = 400

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

-- require our states
require "states/BaseState"
require "states/ConnectState"

-- called once per program
function love.load()
    gStateMachine = StateMachine{
        ["connect"] = function () return ConnectState() end
    }
    gStateMachine:change("connect")
end
--called every frame
function love.update(dt)
    gStateMachine:update(dt)
end
--called every frame
function love.draw()
    gStateMachine:render()
end