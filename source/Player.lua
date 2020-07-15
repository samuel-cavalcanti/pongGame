Player = class(Observer)

function Player:init(keypressMoveUp, keyPressMoveDown)

    self.keys = {
        [keypressMoveUp] = PADDLE_MOVES.UP,
        [keyPressMoveDown] = PADDLE_MOVES.DOWN
    }

end

function Player:signal(message)

    if message.type == MessageTypes.eventListener.keypressed then
        if self.keys[message.value] then
            self:notify(Message(MessageTypes.paddle.PaddleMove,
                                self.keys[message.value]))
        end

    elseif message.type == MessageTypes.eventListener.keyreleased then
        if self.keys[message.value] then
            self:notify(Message(MessageTypes.paddle.PaddleMove, PADDLE_MOVES.STOP))
        end

    end

end
