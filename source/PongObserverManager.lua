PongObserverManager = class(Observer)

function PongObserverManager:init()
    self.currentState = nil
end

function PongObserverManager:signal(message)
    if message.type == MessageTypes.stateMachine.currentState and
        message.value.id ~= self.currentStateId then
        self:modifyObservationsByState(message.value)
        self.currentStateId = message.value.id
    end

end

function PongObserverManager:modifyObservationsByState(state)
    if state.id == GameStates.menu then
        self:enableSelectArrow()

    elseif state.id == GameStates.start then
        self:renderDrawableObjects()
        self:enableKeyboardToControlPlayers()
        self:enablePlayersToControlPaddles()
        self:enableRobot()
        self:disableSelectArrow()

    elseif state.id == GameStates.serve then
        self:enablePaddlesToMove()
        updateGame:remove(ball)

    elseif state.id == GameStates.play then
        updateGame:add(ball)

    elseif state.id == GameStates.victory then
        self:disableMoviment()
        self:disableRobot()
        self:disableKeyboardOfControlPlayers()
        self:disablePlayersToControlPaddles()
        self:stopDrawableObjects()
    end
end

function PongObserverManager:startImudableComunications()

    self:gamePagesToRender()

    self:enableStateMachine()

    self:enablePongGameToControlTheBall()

    self:enablePongGameChangeScoreTable()

    self:enableKeyboardToChangeGameState()

    self:enableSound()

    self:enablePongGameToRecivePosOfPaddles()

end

function PongObserverManager:gamePagesToRender()
    screen:add(gamePages)
    gameStateMachine:add(gamePages)

end

function PongObserverManager:enableStateMachine()
    updateGame:add(gameStateMachine)
    pongGame:add(gameStateMachine)
    gameStateMachine:add(self)
    gameStateMachine:add(pongGame)

end

function PongObserverManager:enablePongGameToControlTheBall()
    ball:add(pongGame)
    pongGame:add(ball)
end

function PongObserverManager:enablePongGameChangeScoreTable()
    pongGame:add(scoreTable)

end

function PongObserverManager:enablePlayersToControlPaddles()
    pongGame.players[1]:add(paddles[1])
    pongGame.players[2]:add(paddles[2])
end

function PongObserverManager:disablePlayersToControlPaddles()
    pongGame.players[1]:remove(paddles[1])
    pongGame.players[2]:remove(paddles[2])
end

function PongObserverManager:enableSound() pongGame:add(pongSound) end

function PongObserverManager:enablePongGameToRecivePosOfPaddles()
    paddles[1]:add(pongGame)
    paddles[2]:add(pongGame)

end

function PongObserverManager:enableRobot()
    ball:add(pongGame.players[2])
    paddles[2]:add(pongGame.players[2])
end

function PongObserverManager:disableRobot()
    ball:remove(pongGame.players[2])
    paddles[2]:remove(pongGame.players[2])

end

function PongObserverManager:enableSelectArrow()
    screen:add(selectArrow)
    keyboard:add(selectArrow)
    selectArrow:add(pongGame)

end

function PongObserverManager:disableSelectArrow()
    screen:remove(selectArrow)
    keyboard:remove(selectArrow)
    selectArrow:remove(pongGame)

end

function PongObserverManager:enablePaddlesToMove()
    updateGame:add(paddles[1])
    updateGame:add(paddles[2])
end

function PongObserverManager:disableMoviment()
    updateGame:remove(ball)
    self:disablePaddlesMovement()
end
function PongObserverManager:disablePaddlesMovement()
    updateGame:remove(paddles[1])
    updateGame:remove(paddles[2])
end

function PongObserverManager:enableKeyboardToChangeGameState()
    keyboard:add(gameStateMachine)
end

function PongObserverManager:enableKeyboardToControlPlayers()
    keyboard:add(pongGame.players[1])
    keyboard:add(pongGame.players[2])
end

function PongObserverManager:disableKeyboardOfControlPlayers()
    keyboard:remove(pongGame.players[1])
    keyboard:remove(pongGame.players[2])
end

function PongObserverManager:renderDrawableObjects()
    self:paddlesToRender()
    screen:add(scoreTable)
    screen:add(ball)
end
function PongObserverManager:paddlesToRender()
    screen:add(paddles[1])
    screen:add(paddles[2])
end

function PongObserverManager:stopDrawableObjects()
    screen:remove(scoreTable)
    screen:remove(ball)
    self:stopRenderPaddles()
end

function PongObserverManager:stopRenderPaddles()
    screen:remove(paddles[1])
    screen:remove(paddles[2])
end

