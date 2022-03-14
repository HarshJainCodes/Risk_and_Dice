Offline_game = Class{__includes = Offline_game}

local play_again = {}
play_again.width = 200
play_again.height = 50
play_again.x = WINDOW_WIDTH/2 - play_again.width/2
play_again.y = WINDOW_HEIGHT/2 + play_again.height/2

function Offline_game:init()
    gui_PlayState = gui_PlayState()

    self.left_bg = love.graphics.newImage("assets/left_bg.png")
    self.right_bg = love.graphics.newImage("assets/right_bg.png")

    self.player1_score = 0
    self.player2_score = 0

    self.player1_current = 0
    self.player2_current = 0

    self.turn = 1

    self.dice_outcome = 1

    self.winner = false
end

function Offline_game:enter(playerNames)
    self.player1 = playerNames[1]
    self.player2 = playerNames[2]
end

function Offline_game:exit()

end

function Offline_game:mousepressed(x, y)
    if x > roll_button.x and x < roll_button.x + roll_button.width and y > roll_button.y and y < roll_button.y + roll_button.height then
        self.dice_outcome = math.random(1, 6)
        if self.dice_outcome ~= 1 then
            if self.turn == 1 then
                self.player1_current = self.player1_current + self.dice_outcome
            else
                self.player2_current = self.player2_current + self.dice_outcome
            end
        else

            if self.turn == 1 then
                self.player1_current = 0
                self.turn = 2
            else
                self.player2_current = 0
                self.turn = 1
            end
        end
    end

    if x > hold_button.x and x < hold_button.x + hold_button.width and y > hold_button.y and y < hold_button.y + hold_button.height then
        if self.turn == 1 then
            self.player1_score = self.player1_score + self.player1_current
            self.player1_current = 0
            self.turn = 2
        else
            self.player2_score = self.player2_score + self.player2_current
            self.player2_current = 0
            self.turn = 1
        end
    end

    if x > play_again.x and x < play_again.x + play_again.width and y > play_again.y and y < play_again.y + play_again.height and self.winner ~= false then
        self.player1_score = 0
        self.player2_score = 0
        self.turn = 1
        self.player1_current = 0
        self.player2_current = 0
        self.winner = false
    end
end

function Offline_game:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function Offline_game:update(dt)
    self.winner = self.player1_score >= 100 and self.player1 or (self.player2_score >= 100 and self.player2)
end

function Offline_game:render()
    --love.graphics.draw(gui_PlayState.background, 0, 0, 0, WINDOW_WIDTH/gui_PlayState.background:getWidth(), WINDOW_HEIGHT/gui_PlayState.background:getHeight())
    if self.turn == 1 then
        love.graphics.draw(self.left_bg, 0, 0, 0, WINDOW_WIDTH/(2 * self.left_bg:getWidth()), WINDOW_HEIGHT/self.right_bg:getHeight())
        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.draw(self.right_bg, WINDOW_WIDTH/2, 0, 0, WINDOW_WIDTH/(2 * self.right_bg:getWidth()), WINDOW_HEIGHT/self.right_bg:getHeight())
    else
        love.graphics.draw(self.right_bg, WINDOW_WIDTH/2, 0, 0, WINDOW_WIDTH/(2 * self.right_bg:getWidth()), WINDOW_HEIGHT/self.right_bg:getHeight())
        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.draw(self.left_bg, 0, 0, 0, WINDOW_WIDTH/(2 * self.left_bg:getWidth()), WINDOW_HEIGHT/self.right_bg:getHeight())
    end

    if self.winner ~= false then
        love.graphics.printf(self.winner.." is the winner", 0, WINDOW_HEIGHT/3, WINDOW_WIDTH, "center")
        love.graphics.rectangle("line", play_again.x, play_again.y, play_again.width, play_again.height, 20, 20)
        love.graphics.printf(" play again", play_again.x, play_again.y, play_again.width)
    else
        gui_PlayState:render()
        local dice_img = gui_PlayState.dice_images[self.dice_outcome]

        love.graphics.draw(dice_img, WINDOW_WIDTH/2 - dice_img:getWidth()/2, WINDOW_HEIGHT/2 - dice_img:getHeight()/2 - 100, 0)
    
    
        love.graphics.setFont(love.graphics.newFont(40))
        love.graphics.printf(self.player1, 0, WINDOW_HEIGHT/4, WINDOW_WIDTH/2, "center")
        love.graphics.printf(self.player2, WINDOW_WIDTH/2, WINDOW_HEIGHT/4, WINDOW_WIDTH/2, "center")
    
        love.graphics.setFont(love.graphics.newFont(70))
        love.graphics.printf(self.player1_score, 0, 300, WINDOW_WIDTH/2, "center")
        love.graphics.printf(self.player2_score, WINDOW_WIDTH/2, 300, WINDOW_WIDTH/2, "center")
    
        love.graphics.setFont(love.graphics.newFont(35))
        love.graphics.printf(self.player1_current, left_display.x, left_display.y + 40, left_display.width, "center")
        love.graphics.printf(self.player2_current, right_display.x, right_display.y + 40, right_display.width, "center")
    end
    
    
end