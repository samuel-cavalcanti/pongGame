UpdateGame = class(Observer)

function UpdateGame:init() self:enableLoveUpdate() end

function UpdateGame:enableLoveUpdate()
    function love.update(dt)
        self:notify(Message(MessageTypes.eventListener.loveUpdate, dt))
       
    end
end
