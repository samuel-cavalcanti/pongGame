GamePages = class(Observer)

function GamePages:init()

    self.color = {r = 1, g = 1, b = 1}
    self.limit = VIRTUAL_WIDTH
    self.align = 'center'

    self.state = nil

end

function GamePages:signal(message)

    if message.type == MessageTypes.eventListener.loveDraw then
        self:draw()

    elseif message.type == MessageTypes.stateMachine.currentState then
        
        self.state = message.value
    end

end

function GamePages:loadFonts(defaultFontMessages, victoryFont)
    self.font = defaultFontMessages
    self.winnerFont = victoryFont

end

function GamePages:draw()
    

    if self.state == nil then return end

    if self.state.id == GameStates.start then
        self:displayWelcomeMessage()

    elseif self.state.id == GameStates.serve then
        self:displayServeMessage()

    elseif self.state.id == GameStates.victory then
        self:displayVictoryMessage()

    elseif self.state.id == GameStates.menu then
        self:displayMenu()
    end

end

function GamePages:displayWelcomeMessage()

    self:setDefaultFontAndColor()

    local x = 0
    local y = 40
    local dy = 12

    local welcomeToPong = "Welcome to Pong!"
    local pressEnter = "Press Enter to Play!"
    local player1Controls = "Player 1 controls: w,s"
    local player2Controls = "Player 2 controls: Arrow Up, Arrow Down"

    love.graphics.printf(welcomeToPong, x, y, self.limit, self.align)
    love.graphics.printf(player1Controls, x, y + dy, self.limit, self.align)
    love.graphics.printf(player2Controls, x, y + 2 * dy, self.limit, self.align)
    love.graphics.printf(pressEnter, x, y + 3 * dy, self.limit, self.align)
end

function GamePages:displayServeMessage()
    self:setDefaultFontAndColor()

    local playerTurn = "Player " .. tostring(self.state.playerTurn) .. "'s turn"
    local pressEnter = "Press Enter to serve!"

    love.graphics.printf(playerTurn, 0, 40, self.limit, self.align)
    love.graphics.printf(pressEnter, 0, 52, self.limit, self.align)

end

function GamePages:setDefaultFontAndColor()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
    love.graphics.setFont(self.font)
end

function GamePages:displayVictoryMessage()

    love.graphics.setColor(self.color.r, self.color.g, self.color.b)

    love.graphics.setFont(self.winnerFont)
    local playerWin = "Player " .. tostring(self.state.winner) .. " Wins"
    love.graphics.printf(playerWin, 0, 40, self.limit, self.align)

    love.graphics.setFont(self.font)
    local pressEnter = "Press Enter to reset game!"
    love.graphics.printf(pressEnter, 0, 72, self.limit, self.align)

end

function GamePages:displayMenu()
    self:setDefaultFontAndColor()

    local x = 0
    local y = 40
    local dy = 12

    local welcomeToPong = "Welcome to Pong!"
    local selectGameMode = "Select Game mode :"
    local multiplayer = "Multiplayer"
    local singlePlayer = "SinglePlayer"

    love.graphics.printf(welcomeToPong, x, y, self.limit, self.align)
    love.graphics.printf(selectGameMode, x, y + dy, self.limit, self.align)
    love.graphics.printf(multiplayer, x, y + 2 * dy, self.limit, self.align)
    love.graphics.printf(singlePlayer, x, y + 3 * dy, self.limit, self.align)

end
