ScoreTable = class(Observer)

function ScoreTable:init()

    self.centerX = VIRTUAL_WIDTH * 0.5 - 7
    self.centerY = VIRTUAL_HEIGHT * 0.3

    self.color = {r = 1, g = 1, b = 1}
    self.scorePlayer1PosX = self.centerX - 30
    self.scorePlayer2PosX = self.centerX + 25

end

function ScoreTable:signal(message)

    if message.value then

        if message.type == MessageTypes.eventListener.loveDraw then
            self:draw()

        elseif message.type == MessageTypes.scoreTable.setScore then

            self:setScore(message.value)
        end
    end

end

function ScoreTable:loadFont(font) self.font = font end

function ScoreTable:draw()

    love.graphics.setFont(self.font)
    love.graphics.setColor(self.color.r, self.color.g, self.color.b, 1)

    love.graphics.print(self.score[1], self.scorePlayer1PosX, self.posY)
    love.graphics.print(self.score[2], self.scorePlayer2PosX, self.posY)

end

function ScoreTable:setScore(score) self.score = score end

