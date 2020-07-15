PongGame = class(Observer)

function PongGame:init(maxScore)
    self:initializePlayersWithNill()
    self.maxScore = maxScore
    self:resetScore()
    self.paddles = {}
    self.paddlesCollision = {}
    self.winner = false
end

function PongGame:initializePlayersWithNill()
    self.players = {[1] = nil, [2] = nil}
end

function PongGame:signal(message)

    if message.type == MessageTypes.ball.move then
        self:updateBallPos(message.value)
        self:verifyBallMoviment()
        self:updateScore()
        self:sendNotifications()

    elseif message.type == MessageTypes.paddle.paddlePosition then
        self:updatePaddlePos(message.value)

    elseif message.type == MessageTypes.selectArrow.selected then
        self:selectNumberOfPlayers(message.value)
        self:notifyScoreBoard()

    elseif message.type == MessageTypes.scoreTable.resetScore then
        print('reseting')
        self:resetGame()
    end

end

function PongGame:updateBallPos(ballPos) self.ball = ballPos end

function PongGame:verifyBallMoviment()

    self:preventBallToVerticalCamOut()
    self:preventBallToHorizontalCamOut()

    self.paddlesCollision[1] = self:verifyColisionBetweenPadddleAndBall(
                                   self.paddles[1])

    self.paddlesCollision[2] = self:verifyColisionBetweenPadddleAndBall(
                                   self.paddles[2])

end

function PongGame:preventBallToVerticalCamOut()
    local heightLimit = VIRTUAL_HEIGHT - self.ball.size
    self.verticalCamout = false

    if self.ball.y <= 0 then
        self.ball.y = 0
        self.verticalCamout = true

    elseif self.ball.y >= heightLimit then
        self.ball.y = heightLimit
        self.verticalCamout = true
    end

end

function PongGame:preventBallToHorizontalCamOut()
    local widthLimit = VIRTUAL_WIDTH - self.ball.size
    self.horizontalCamout = false

    if self.ball.x >= widthLimit then
        self.horizontalCamout = 1
        self.ball.x = widthLimit

    elseif self.ball.x <= 0 then
        self.horizontalCamout = 2
        self.ball.x = 0 
    end

end

function PongGame:verifyColisionBetweenPadddleAndBall(paddle)

    if paddle == nil then return false end

    if self.ball.x > paddle.x + paddle.width or self.ball.x + self.ball.size <
        paddle.x then return false end

    if self.ball.y > paddle.y + paddle.height or self.ball.y + self.ball.size <
        paddle.y then return false end

    return true

end

function PongGame:updatePaddlePos(paddle) self.paddles[paddle.id] = paddle end

function PongGame:selectNumberOfPlayers(singleplayerMode)
    if singleplayerMode then
        self:singlePlayerGame()
    else
        self:multiplayerGame()
    end

end

function PongGame:multiplayerGame()
    print('Multiplayer Mode')
    self:initializePlayersWithNill()
    self:inserPlayer(Player('w', 's'))
    self:inserPlayer(Player('up', 'down'))
end

function PongGame:singlePlayerGame()
    print('singleplayer Mode')
    self:initializePlayersWithNill()
    self:inserPlayer(Player('w', 's'))
    self:inserPlayer(Robot())
end

function PongGame:inserPlayer(player)
    if self:isPossibleToBePlayer(1) then
        self:addPlayer(1, player)

    elseif self:isPossibleToBePlayer(2) then
        self:addPlayer(2, player)
    end
end

function PongGame:isPossibleToBePlayer(number) return
    self.players[number] == nil end

function PongGame:addPlayer(number, player)
    self.players[number] = player
    self.paddles[number] = nil
end

function PongGame:sendNotifications()
    self:notifyPongSound()
    self:notifyBall()
    self:notifyStateMachine()
    if self:anyPlayerHasScored() then self:notifyScoreBoard() end

end

function PongGame:notifyPongSound()

    self:notify(Message(MessageTypes.sound.playerScored,
                        self:anyPlayerHasScored()))

    self:notify(Message(MessageTypes.sound.paddleCollision,
                        self:anyPaddleHasCollide()))

    self:notify(Message(MessageTypes.sound.wallCollision, self.verticalCamout))
end

function PongGame:notifyBall()
    self:notify(Message(MessageTypes.ball.resetPos, self:anyPlayerHasScored()))
    self:notify(Message(MessageTypes.ball.invertSpeedX, self:invertBallSpeedX()))

    self:notify(Message(MessageTypes.ball.invertSpeedY, self.verticalCamout))
end

function PongGame:invertBallSpeedX()
    if self.paddlesCollision[1] or self.paddlesCollision[2] then return true end

    return false

end

function PongGame:notifyStateMachine()
    self:notify(Message(MessageTypes.stateMachine.playerScored,
                        self:anyPlayerHasScored()))

    if self.winner then
        self:notify(Message(MessageTypes.stateMachine.victory, self.winner))
    end
end

function PongGame:notifyScoreBoard()

    self:notify(Message(MessageTypes.scoreTable.setScore, self.score))

end

function PongGame:anyPlayerHasScored()
    if self.horizontalCamout ~= false and self:anyPaddleHasCollide() == false then

        return self.horizontalCamout
    end
end

function PongGame:anyPaddleHasCollide()
    if self.paddlesCollision[1] == nil or self.paddlesCollision[2] == nil then
        return false
    end
    return self.paddlesCollision[1] == true or self.paddlesCollision[2] == true
end

function PongGame:updateScore()
    if self.horizontalCamout == false or self:anyPaddleHasCollide() then return end


    self.score[self.horizontalCamout] = self.score[self.horizontalCamout] + 1
    print('update score', self.score[1], self.score[2])

    if self.score[self.horizontalCamout] == self.maxScore then
        self.winner = self.horizontalCamout
    end

end

function PongGame:resetGame()
    self:resetFlags()
    self:resetScore()
    self.winner = false

end

function PongGame:resetScore() self.score = {[1] = 0, [2] = 0} end

function PongGame:resetFlags()
    self.horizontalCamout = false
    self.verticalCamout = false
end
