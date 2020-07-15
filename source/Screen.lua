Screen = class(Observer)

function Screen:init()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
                     {fullscreen = false, vsync = true, resizable = true})

    self.backgroundColor = {r = 40 / 255, g = 45 / 255, b = 52 / 255}

    self:startToDraw()

end

function Screen:drawBackground()
    love.graphics.clear(self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b, 1)
end

function Screen:displayFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(smallFont)
    local fps = tostring(love.timer.getFPS())

    love.graphics.print('FPS: ' .. fps, 40, 10)
    love.graphics.setColor(1, 1, 1, 1)

end


function Screen:startToDraw()
    local message = Message(MessageTypes.eventListener.loveDraw, true)

    function love.draw()
        Push:start()

        self:drawBackground()

        self:notify(message)

        Push:finish()

    end

    function love.resize(w, h) Push:resize(w, h) end
    
end
