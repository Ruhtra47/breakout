Class = require 'class'
push = require 'push'

require 'constants'
require 'menus'
require 'Brick'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 300

function love.load()

    love.window.setTitle('Breakout')

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    liveImage = love.graphics.newImage('graphics/heart.png')

    smallFont = love.graphics.newFont('font.ttf', 8)
    endFont = love.graphics.newFont('font.ttf', 24)
    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    paddle = Paddle(VIRTUAL_WIDTH / 2 - 25, VIRTUAL_HEIGHT - 20, 50, 10)

    ball = Ball(VIRTUAL_WIDTH / 2 - 4, VIRTUAL_HEIGHT - 50, 8, 8)

    bricks = {}

    lives = 3

    setBricks()

    gameState = 'start'
end

function love.update(dt)
    paddle:update(dt)

    if gameState == playState then
        ball:update(dt)

        if lives <= 0 then
            gameState = loseState
        end

        for i = 1, #bricks do
            if bricks[i] ~= nil then
                if bricks[i]:collides() then
                    ball.dy = -ball.dy

                    bricks[i] = nil
                end
            end
        end

        if ball:collidesPaddle() then
            ball.dy = -ball.dy
            ball.dx = math.random(-200, 200)
        end

        if gameEnded() then
            gameState = winState
        end
    end
end

function setBricks()
    for y = 0, 50, 10 do
        for x = 0, 378, 54 do
            table.insert(bricks, Brick(x, y, 54, 10))
        end
    end
end

function resetGame()
    gameState = startState

    lives = 3

    paddle:reset()
    ball:reset()

    setBricks()
end

function gameEnded()
    for i = 1, #bricks do
        if bricks[i] ~= nil then
            return false
        end
    end
    return true
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if gameState == startState then
            gameState = serveState
        elseif gameState == serveState then
            gameState = playState
        elseif gameState == winState or gameState == loseState then
            resetGame()
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)

    paddle:render()
    ball:render()

    for i = 1, #bricks do
        if bricks[i] ~= nil then
            bricks[i]:render()
        end
    end

    if gameState == startState then
        menus.start()
    elseif gameState == serveState then
        menus.serve()
    elseif gameState == winState then
        menus.win()
    elseif gameState == loseState then
        menus.lose()
    end

    drawFPS()
    drawLives()

    push:apply('end')

end

function drawLives()
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.setFont(smallFont)
    love.graphics.print('Lives:', 5, VIRTUAL_HEIGHT - 15)

    -- love.graphics.draw(liveImage, 30, VIRTUAL_HEIGHT - 17, 0, 0.025, 0.025)
    -- love.graphics.draw(liveImage, 50, VIRTUAL_HEIGHT - 17, 0, 0.025, 0.025)
    -- love.graphics.draw(liveImage, 70, VIRTUAL_HEIGHT - 17, 0, 0.025, 0.025)

    marginLeft = 30
    for i = 1, lives do
        love.graphics.draw(liveImage, marginLeft, VIRTUAL_HEIGHT - 17, 0, 0.025, 0.025)
        marginLeft = marginLeft + 20
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function drawFPS()
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.setFont(smallFont)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), VIRTUAL_WIDTH - 40, VIRTUAL_HEIGHT - 15)
    love.graphics.setColor(1, 1, 1, 1)
end
