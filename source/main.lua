WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

MAX_SCORE = 5

require "baseClass/class" -- lua classes

require "baseClass/Observer" -- obeserver Patter

require "baseClass/Message" -- observer Patter

Push = require "thirdLibrary/push" -- require the library

require "Player"

require "Ball"

require "ScoreTable"

require "GameStateMachine"

require "GamePages"

require "UpdateGame"

require "Screen"

require "Keyboard"

require "PongSound"

require "Paddle"

require "PongGame"

require "PongObserverManager"

require "SelectArrow"

require "artificialIntelligence.Robot"

math.randomseed(os.time())

local function createPaddles()
    local sizePaddle = {width = 5, height = 20}
    local paddleSpeed = 200

    return {
        [1] = Paddle(0, 0, sizePaddle.width, sizePaddle.height, paddleSpeed),
        [2] = Paddle(VIRTUAL_WIDTH - sizePaddle.width,
                     VIRTUAL_HEIGHT - sizePaddle.height, sizePaddle.width,
                     sizePaddle.height, paddleSpeed)
    }

end

local function loadFonts(pathToFont)
    local fonts = {
        smallFontSize = love.graphics.newFont(pathToFont, 8),

        mediumFontSize = love.graphics.newFont(pathToFont, 32),

        largeFontSize = love.graphics.newFont(pathToFont, 24)
    }
    return fonts
end

pongGame = PongGame(MAX_SCORE)
updateGame = UpdateGame()
keyboard = Keyboard()
pongSound = PongSound()
gameStateMachine = GameStateMachine()
screen = Screen()
gamePages = GamePages()
scoreTable = ScoreTable()
paddles = createPaddles()
ball = Ball()
selectArrow = SelectArrow()
observerManager = PongObserverManager()

function love.load()
    local fonts = loadFonts('fonts/font.TTF')
    pongSound:loadSounds('sounds/')
    gamePages:loadFonts(fonts.smallFontSize, fonts.largeFontSize)
    scoreTable:loadFont(fonts.mediumFontSize)
    selectArrow:loadFont(fonts.smallFontSize)

    observerManager:startImudableComunications()
end

