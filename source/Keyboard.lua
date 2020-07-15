Keyboard = class(Observer)

function Keyboard:init()

    function love.keypressed(key, scancode, isrepeat)
        self:notify(Message(MessageTypes.eventListener.keypressed, key))

        if key == 'escape' then love.event.quit() end
    end

    function love.keyreleased(key)
        self:notify(Message(MessageTypes.eventListener.keyreleased, key))

    end

end
