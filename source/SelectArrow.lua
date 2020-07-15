SelectArrow = class(Observer)

function SelectArrow:init()
    self.color =  {r = 1, g = 1, b = 1}
    self.limit = VIRTUAL_WIDTH
    self.align = 'center'
    self.arrow = '-->'

    self.x = -35
    self.y = 64
    self.dy = 12
    self.singleplayer = false

end

function SelectArrow:loadFont(font) self.font = font end

function SelectArrow:selectFontAndColor()
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)
    love.graphics.setFont(self.font)
end

function SelectArrow:signal(message)

    if message.type == MessageTypes.eventListener.keypressed then
        self:controlArrow(message.value)
        self:notifyChoose(message.value)

    elseif message.type == MessageTypes.eventListener.loveDraw then
        self:draw()
    end
end

function SelectArrow:controlArrow(key)
    if key == 'up' or key == 'w' then
        self:moveUp()

    elseif key == 'down' or key == 's' then
        self:moveDown()

    end

end

function SelectArrow:moveUp()
    if self.singleplayer then
        self.y = self.y - self.dy
        self.singleplayer = false
    end
end

function SelectArrow:moveDown()
    if self.singleplayer == false then
        self.y = self.y + self.dy
        self.singleplayer = true
    end

end

function SelectArrow:notifyChoose(key)
    if key == 'enter' or key == 'return' then
        self:notify(
            Message(MessageTypes.selectArrow.selected, self.singleplayer))
    end
end

function SelectArrow:draw()
    self:selectFontAndColor()
    love.graphics.printf(self.arrow, self.x, self.y, self.limit, self.align)
end
