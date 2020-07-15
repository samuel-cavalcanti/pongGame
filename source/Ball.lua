Ball = class(Observer)

function Ball:init()

    self.size = 5
    self.initSpeed = {x = 100, y = 50}
    self.initPos = {x = VIRTUAL_WIDTH / 2 - 2, y = VIRTUAL_HEIGHT / 2}

    self.x = self.initPos.x
    self.y = self.initPos.y

    self.dv = 0.25

    self.maxSpeed = {x = 500, y = 300}

    self:gerateSpeed(math.random(2))

end

function Ball:signal(message)

    if message.type == MessageTypes.eventListener.loveDraw and message.value then
        self:draw()

    elseif message.type == MessageTypes.eventListener.loveUpdate then
        self:move(message.value)
        self:notify(Message(MessageTypes.ball.move, self))

    elseif message.type == MessageTypes.ball.resetPos and message.value then
        self:reset(message.value)

    elseif message.type == MessageTypes.ball.invertSpeedX and message.value then
        self:invertSpeedX()

    elseif message.type == MessageTypes.ball.invertSpeedY and message.value then
        self:invertSpeedY()

    end

end

function Ball:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

function Ball:move(dt)
    self.x = self.x + self.speed.x * dt
    self.y = self.y + self.speed.y * dt
end

function Ball:changeState(currentState)

    if currentState.id ~= GameStates.play then
        self:reset(currentState.playerTurn)
    end
end

function Ball:reset(playerHasScored)
    local playerTurn = playerHasScored == 1 and 2 or 1
    self:gerateSpeed(playerTurn)

    self.x = self.initPos.x
    self.y = self.initPos.y
end

function Ball:gerateSpeed(playerTurn)
    self.speed = {
        x = playerTurn == 2 and -self.initSpeed.x or self.initSpeed.x,
        y = math.random(-self.initSpeed.y, self.initSpeed.y)
    }

end

function Ball:invertSpeedY()
    self.speed.y = -(self.speed.y + 0.25 * self.speed.y)

    print(self.speed.y)

    if math.abs(self.speed.y) > self.maxSpeed.y then
        self.speed.y = self.speed.y > 0 and self.maxSpeed.y or -self.maxSpeed.y
    end
end

function Ball:invertSpeedX()

    self.speed.x = -(self.speed.x + 0.25 * self.speed.x)

    if math.abs(self.speed.x) > self.maxSpeed.x then
        self.speed.x = self.speed.x > 0 and self.maxSpeed.x or -self.maxSpeed.x
    end

end

