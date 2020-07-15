GameStateMachine = class(Observer)

local id = -1

local function nexID()
    id = id + 1
    return id
end

GameStates = {
    menu = nexID(),
    start = nexID(),
    play = nexID(),
    serve = nexID(),
    victory = nexID()
}

function GameStateMachine:init()

    self.state = {
        playerTurn = math.random(2),
        winner = false,
        id = GameStates.menu,
        playerHasScored = false,
        pressEnter = false
    }

end

function GameStateMachine:signal(message)

    if message.type == MessageTypes.eventListener.keypressed and
        (message.value == 'enter' or message.value == 'return') then
        self:pressEnterUpdate(message.value)

    elseif message.type == MessageTypes.eventListener.loveUpdate then
        self:notify(Message(MessageTypes.stateMachine.currentState, self.state))
        self:updateStateId()

    elseif message.type == MessageTypes.stateMachine.playerScored then
        self.state.playerHasScored = message.value

    elseif message.type == MessageTypes.stateMachine.victory then
        self:setWinner(message.value)

    end

end

function GameStateMachine:pressEnterUpdate(key)

    if key == 'enter' or key == 'return' then self.state.pressEnter = true end

end

function GameStateMachine:setWinner(playerID) self.state.winner = playerID print('winner', self.state.winner) end

function GameStateMachine:updatePlayersTurn()
    self.state.playerTurn = self.state.playerHasScored == 2 and 1 or 2

end

function GameStateMachine:updateStateId()

    if self.state.id == GameStates.menu then
        self:menuState()

    elseif self.state.id == GameStates.start then
        self:startState()

    elseif self.state.id == GameStates.serve then
        self:serveState()

    elseif self.state.id == GameStates.play then
        self:playState()

    elseif self.state.id == GameStates.victory then
        self:victoryState()

    end

end

function GameStateMachine:menuState()
    if self.state.pressEnter then
        self:reset()
        self.state.id = GameStates.start
    end

end

function GameStateMachine:reset()
    self.state.playerHasScored = false
    self.state.pressEnter = false
    self.state.winner = false
end

function GameStateMachine:startState()
    if self.state.pressEnter then
        self:reset()
        self.state.id = GameStates.serve
    end

end

function GameStateMachine:serveState()
    if self.state.pressEnter then
        self:reset()
        self.state.id = GameStates.play
    end

end

function GameStateMachine:playState()

    if self.state.winner ~= false then
        self.state.id = GameStates.victory
      
        print('notifing reset talble')
        self:notify(Message(MessageTypes.scoreTable.resetScore, true))

    elseif self.state.playerHasScored then
        self.state.id = GameStates.serve
        self:reset()
        self:updatePlayersTurn()
    end

end

function GameStateMachine:victoryState()
    if self.state.pressEnter then
        self:reset()
        self.state.id = GameStates.menu
    end

end

