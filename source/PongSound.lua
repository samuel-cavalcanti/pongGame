PongSound = class(Observer)

function PongSound:loadSounds(path)
    self.path = path

    self.sounds = {
        paddle = self:loadSound('paddle'),
        wall = self:loadSound('wall'),
        score = self:loadSound('score')
    }

end

function PongSound:loadSound(name)
    local mode = 'static'
    local format = '.mp3'
    return love.audio.newSource(self.path .. name .. format, mode)
end

function PongSound:signal(message)

    if message.value then

        if message.type == MessageTypes.sound.paddleCollision then
            self.sounds.paddle:play()

        elseif message.type == MessageTypes.sound.playerScored then
            self.sounds.score:play()

        elseif message.type == MessageTypes.sound.wallCollision then
            self.sounds.wall:play()
        end

    end

end

