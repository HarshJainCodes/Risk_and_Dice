ConnectState = Class{__includes = BaseState}

math.randomseed(os.time())

playerName = {"p1", "p2"} -- to store the player names

turn = 1
player_score = {0, 0}   -- keep record of player scores
a = math.random(1, 6)   -- dice value
player_tab = 0  -- player current score
total_player = 0    -- total number of players
roll = false    -- whether to roll the dice

function ConnectState:init()
    self.total_players = 0 -- keep track of total players
    self.serverAddress = socket.dns.toip(socket.dns.gethostname()) -- the address of the current network you are in
    self.port = 16 -- port number
    --self.server = sock.newServer(self.serverAddress, self.port, 2) -- 2 here means the maximum number of clients that can join
    self.server = sock.newServer("localhost", 16, 2)
    --self.server = sock.newServer("localhost", 8000, 2)
    self.server:setSerialization(bitser.dumps, bitser.loads) -- both the client and server should have the same serialisation
    self.status = "not connected"
    
    self.server:on("connect", function (data, client)
        self.status = "connected"
        --client:send("player_num", client:getIndex()) -- assign as index to the connected client
        client:send("playerNum", client:getIndex())
        self.total_players = self.total_players + 1
    end)

    self.server:on("player_roll", function (a)
        roll = a == turn and true or false
        -- if the player whose turn it is to roll clicks on the roll button then roll the dice
    end)

    self.server:on("player_next", function (b)
        if b == turn then
            player_score[turn] = player_score[turn] + player_tab
            turn = turn == 1 and 2 or 1     -- change the turn
            player_tab = 0      -- current score becomes 0
        end
    end)

    self.server:on("selfname", function (data, client)
        playerName[client:getIndex()] = data
        clientIndex = client:getIndex()
    end)
end

function ConnectState:update(dt)
    self.server:update()
    if roll == true then
        a = math.random(1, 6)
        if a ~= 1 then
            player_tab = player_tab + a
        else
            player_tab = 0
            turn = turn == 1 and 2 or 1
        end
        roll = false
    end
    
    if self.total_players >= 2 then
        self.server:sendToAll("bothnames", playerName)
    end

    self.server:sendToAll("playerState", {a, player_tab, player_score[1], player_score[2]})
    self.server:sendToAll("current_player", turn)
end

function ConnectState:render()
    love.graphics.print(self.status)
    love.graphics.print("enter this ip : "..self.serverAddress.." ".."and port number "..self.port, 100, 100)
    
    if playerName[1] ~= nil then
        love.graphics.print(playerName[1], 0, 100)
    end
    if playerName[2] ~= nil then
        love.graphics.print(playerName[2], 0, 200)
    end
end