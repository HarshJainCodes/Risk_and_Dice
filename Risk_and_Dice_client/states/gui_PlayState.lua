gui_PlayState = Class{}


function gui_PlayState:init()
    self.background = love.graphics.newImage("assets/background.png")
    self.left_background = love.graphics.newImage("assets/left_bg.png")
    self.right_background = love.graphics.newImage("assets/right_bg.png")
    self.dice_images = {}
    self.dice_image_1 = love.graphics.newImage("assets/dice_image1.png")
    self.dice_image_2 = love.graphics.newImage("assets/dice_image2.png")
    self.dice_image_3 = love.graphics.newImage("assets/dice_image3.png")
    self.dice_image_4 = love.graphics.newImage("assets/dice_image4.png")
    self.dice_image_5 = love.graphics.newImage("assets/dice_image5.png")
    self.dice_image_6 = love.graphics.newImage("assets/dice_image6.png")

    table.insert(self.dice_images, self.dice_image_1)
    table.insert(self.dice_images, self.dice_image_2)
    table.insert(self.dice_images, self.dice_image_3)
    table.insert(self.dice_images, self.dice_image_4)
    table.insert(self.dice_images, self.dice_image_5)
    table.insert(self.dice_images, self.dice_image_6)

end

roll_button = {}
roll_button.width = 190
roll_button.height = 80
roll_button.x = WINDOW_WIDTH/2 - roll_button.width/2
roll_button.y = 400

hold_button = {}
hold_button.width = 190
hold_button.height = 80
hold_button.x = WINDOW_WIDTH/2 - hold_button.width/2
hold_button.y = 500

left_display = {}
left_display.width = WINDOW_WIDTH/2 - 300
left_display.height = 100
left_display.x = WINDOW_WIDTH/4 - left_display.width/2
left_display.y = 500

right_display = {}
right_display.width = WINDOW_WIDTH/2 - 300
right_display.height = 100
right_display.x = 0.75 * WINDOW_WIDTH - right_display.width/2
right_display.y = 500

function gui_PlayState:render()
    --love.graphics.draw(self.background, 0, 0, 0, WINDOW_WIDTH/self.background:getWidth(), WINDOW_HEIGHT/self.background:getHeight())
    love.graphics.setFont(love.graphics.newFont(40))
    --love.graphics.printf("player1", 0, WINDOW_HEIGHT/4, WINDOW_WIDTH/2, "center")
    --love.graphics.printf("player2", WINDOW_WIDTH/2, WINDOW_HEIGHT/4, WINDOW_WIDTH/2, "center")
    --local dice_img = self.dice_images[self.dice_outcome]
    --love.graphics.draw(dice_img, WINDOW_WIDTH/2 - dice_img:getWidth()/2, WINDOW_HEIGHT/3 - dice_img:getHeight()/2)
    
    love.graphics.setFont(love.graphics.newFont(25))
    love.graphics.rectangle("line", roll_button.x, roll_button.y, roll_button.width, roll_button.height, 20, 20)
    love.graphics.printf("Roll Dice", roll_button.x, roll_button.y + roll_button.height/3, roll_button.width, "center")

    love.graphics.rectangle("line", hold_button.x, hold_button.y, hold_button.width, hold_button.height, 20, 20)
    love.graphics.printf("Hold", hold_button.x, hold_button.y + roll_button.height/3, hold_button.width, "center")

    love.graphics.rectangle("line", left_display.x, left_display.y, left_display.width, left_display.height, 20, 20)
    love.graphics.printf("current", left_display.x, left_display.y + 2, left_display.width, "center")
    love.graphics.rectangle("line", right_display.x, right_display.y, right_display.width, right_display.height, 20, 20)
    love.graphics.printf("current", right_display.x, right_display.y + 2, right_display.width, "center")

    love.graphics.setFont(love.graphics.newFont(70))
    --love.graphics.printf(20, 0, 350, WINDOW_WIDTH/2, "center")
    --love.graphics.printf(30, WINDOW_WIDTH/2, 350, WINDOW_WIDTH/2, "center")
    
    love.graphics.setFont(love.graphics.newFont(35))
    --love.graphics.printf(40, left_display.x, left_display.y + 40, left_display.width, "center")
    --love.graphics.printf(50, right_display.x, right_display.y + 40, right_display.width, "center")
end