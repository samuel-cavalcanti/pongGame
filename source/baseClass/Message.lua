local id = -1

local function nexID()
    id = id + 1
    return id
end

MessageTypes = {
    eventListener = {
        keypressed = nexID(),
        keyreleased = nexID(),
        loveUpdate = nexID(),
        loveDraw = nexID()
    },
    ball = {
        move = nexID(),
        invertSpeedX = nexID(),
        invertSpeedY = nexID(),
        setPos = nexID(),
        resetPos = nexID()
    },

    paddle = {
        paddlePosition = nexID(),
        setPaddleSpeed = nexID(),
        PaddleMove = nexID()
    },

    stateMachine = {
        gameState = nexID(),
        victory = nexID(),
        currentState = nexID(),
        playerTurn = nexID(),
        playerScored = nexID()
    },

    scoreTable = {resetScore = nexID(), setScore = nexID()},

    sound = {
        wallCollision = nexID(),
        paddleCollision = nexID(),
        playerScored = nexID()
    },

    selectArrow = {selected = nexID()},

    artificialInteligence = {
        perceptronOutput = nexID(),
        perceptronInput = nexID(),
        perceptronLayerOutput = nexID(),
        perceptronTrain = nexID(),
        perceptronLayerInput = nexID(),
        perceptronLayerTrain = nexID()
    }

}

Message = class()

function Message:init(typeMessage, value, subjectID)

    self.type = typeMessage
    self.value = value
    self.__subjectID = subjectID

end
