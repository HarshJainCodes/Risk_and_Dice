PlayState = Class{__includes = BaseState}
require "states/gui_PlayState"

function PlayState:init()
    math.randomseed(os.time())
    self.dice_outcome = 0
    self.playerNum = 0
    self.dice = 0
    self.winner = ""
    gui_PlayState = gui_PlayState()

    --self.client = sock.newClient(self.ip, tonumber(self.port))
    self.client = sock.newClient("localhost", 16)
    self.client:setSerialization(bitser.dumps, bitser.loads)
    self.client:connect()
    
    self.client:setSchema("playerState", {"a", "b", "c", "d"})


    self.client:on("playerState", function (data)
        dice = data.a
        player_tab = data.b
        player1_score = data.c
        player2_score = data.d
    end)

    self.client:on("current_player", function (data)
        current_turn = data
    end)

    
    self.client:on("playerNum", function (num)
        playerNumber = num
    end)
    self.client:setSchema("playerState", {"a", "b", "c", "d"})
end

player_tab = 0
player1_score = 0
player2_score = 0
current_turn = nil

function PlayState:textinput(t)
    
end

local playerName = {"", ""}
local playerScore = {0, 0}
local currentScore = {0, 0}

dummy_dice = {}


function PlayState:enter(data)
    self.ip = data[1]
    self.port = data[2]
    playerName[1] = data[3]
    
end

local send_details = 0
score_update = false

function PlayState:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function PlayState:mousepressed(x, y)
    if x > roll_button.x and x < roll_button.x + roll_button.width and y > roll_button.y and y < roll_button.y + roll_button.height then
        self.client:send("player_roll", playerNumber)
        
    end
    if x > hold_button.x and x < hold_button.x + hold_button.width and y > hold_button.y and y < hold_button.y + hold_button.height then
        self.client:send("player_next", playerNumber)
    end
end

function PlayState:update(dt)
    self.client:update()

    -- self.client:on("player_num", function (data)
    --     self.playerNum = data
    -- end)

    if send_details < 2 then
        self.client:send("selfname", playerName[1])
        send_details = send_details + 1
    end
    self.client:on("bothnames", function (data)
        playerName[1] = data[1]
        playerName[2] = data[2]
    end)
    if player1_score >= 100 then
        self.winner = playerName[1]
    end
    if player2_score >= 100 then
        self.winner = playerName[2]
    end
end


function PlayState:render()
    if current_turn == 1 then
        love.graphics.draw(gui_PlayState.left_background, 0, 0, 0, (WINDOW_WIDTH/2)/gui_PlayState.left_background:getWidth(), WINDOW_HEIGHT/gui_PlayState.right_background:getHeight())

        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.draw(gui_PlayState.right_background, WINDOW_WIDTH/2, 0, 0, (WINDOW_WIDTH/2)/gui_PlayState.right_background:getWidth(), WINDOW_HEIGHT/gui_PlayState.right_background:getHeight())
        
    else
        love.graphics.draw(gui_PlayState.right_background, WINDOW_WIDTH/2, 0, 0, (WINDOW_WIDTH/2)/gui_PlayState.right_background:getWidth(), WINDOW_HEIGHT/gui_PlayState.right_background:getHeight())

        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.draw(gui_PlayState.left_background, 0, 0, 0, (WINDOW_WIDTH/2)/gui_PlayState.left_background:getWidth(), WINDOW_HEIGHT/gui_PlayState.right_background:getHeight())
        
    end
    love.graphics.setColor(1, 1, 1)

    gui_PlayState:render()
    if #self.winner ~= 0 then
        love.graphics.draw(gui_PlayState.background, 0, 0, 0, WINDOW_WIDTH/gui_PlayState.background:getWidth(), WINDOW_HEIGHT/gui_PlayState.background:getHeight())
        love.graphics.printf(self.winner.." is the winner", 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, "center")
    else
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf(playerName[1], 0, WINDOW_HEIGHT/4, WINDOW_WIDTH/2, "center")
        love.graphics.printf(playerName[2], WINDOW_WIDTH/2, WINDOW_HEIGHT/4, WINDOW_WIDTH/2, "center")
        local dice_img = gui_PlayState.dice_images[dice]
    
        if dice_img ~= nil then
            love.graphics.draw(dice_img, WINDOW_WIDTH/2 - dice_img:getWidth()/2, WINDOW_HEIGHT/3 - dice_img:getHeight()/2)
        end
        love.graphics.setFont(love.graphics.newFont(70))
    
        love.graphics.printf(player1_score,  0, 350, WINDOW_WIDTH/2, "center")
        love.graphics.printf(player2_score, WINDOW_WIDTH/2, 350, WINDOW_WIDTH/2, "center")
    
        love.graphics.setFont(love.graphics.newFont(35))
        if current_turn == 1 then
            love.graphics.printf(player_tab, left_display.x, left_display.y + 40, left_display.width, "center")
            love.graphics.printf(0, right_display.x, right_display.y + 40, right_display.width, "center")
        else
            love.graphics.printf(0, left_display.x, left_display.y + 40, left_display.width, "center")
            love.graphics.printf(player_tab, right_display.x, right_display.y + 40, right_display.width, "center")
        end
    end
end