Robot = class(Observer)

function Robot:init()
    self.movePaddle = {
        up = PADDLE_MOVES.UP,
        down = PADDLE_MOVES.DOWN,
        stop = PADDLE_MOVES.STOP
    }
    self.ball = nil
    self.paddle = nil
    self.action = nil

end

function Robot:signal(message)

    if message.type == MessageTypes.ball.move then
        self:getCurrentBallPos(message.value)
        self:chooseAction()
        self:notifyPaddle()

    elseif message.type == MessageTypes.paddle.paddlePosition then
        self:getCurrentPaddlePos(message.value)
    end

end

function Robot:getCurrentBallPos(ball) self.ball = ball end

function Robot:getCurrentPaddlePos(paddle) self.paddle = paddle end

function Robot:chooseAction()
    if self.ball == nil or self.paddle == nil then
        self.action = PADDLE_MOVES.STOP
        return
    end

    local centerY = self.paddle.y + self.paddle.height / 2

    if self.ball.y > centerY then
        self.action = PADDLE_MOVES.DOWN
    elseif self.ball.y < centerY then
        self.action = PADDLE_MOVES.UP
    else
        self.action = PADDLE_MOVES.STOP
    end

end

function Robot:notifyPaddle()
    self:notify(Message(MessageTypes.paddle.PaddleMove, self.action))
end