Paddle = class(Observer)

PADDLE_MOVES = {UP = 1, DOWN = 2, STOP = 3}
local id = 0
local function nexID()
    id = 1 + id
    return id
end

function Paddle:init(x, y, width, height, speed)

    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.speeds = {
        [PADDLE_MOVES.UP] = -speed,
        [PADDLE_MOVES.DOWN] = speed,
        [PADDLE_MOVES.STOP] = 0
    }

    self.speed = 0

    self.id = nexID()

end

function Paddle:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Paddle:signal(message)

    if message.type == MessageTypes.eventListener.loveUpdate then
        self:move(message.value)
        self:notify(Message(MessageTypes.paddle.paddlePosition, self))

    elseif message.type == MessageTypes.eventListener.loveDraw and message.value then
        self:draw()

    elseif message.type == MessageTypes.paddle.PaddleMove then
        self.speed = self.speeds[message.value]

    end

end

function Paddle:move(dt)

    local pos = self.speed * dt

    if self.speed < 0 then
        self.y = math.max(0, self.y + pos)

    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + pos)

    end

end
