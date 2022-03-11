Ball = Class {}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = math.random(2) == 1 and -200 or 200
    self.dy = -200
end

function Ball:collidesPaddle()
    if self.y + self.height >= paddle.y and self.x >= paddle.x and self.x + self.width <= paddle.x + paddle.width then
        self.y = paddle.y - self.height
        return true
    end

    return false
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.y <= 0 then
        self.dy = -self.dy
    elseif self.y >= VIRTUAL_HEIGHT - 4 then
        ball:reset()
        lives = lives - 1
        gameState = serveState
    end

    if self.x <= 0 or self.x >= VIRTUAL_WIDTH - 4 then
        self.dx = -self.dx
    end
end

function Ball:render()
    love.graphics.rectangle('fill', math.floor(self.x), math.floor(self.y), self.width, self.height)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 4
    self.y = VIRTUAL_HEIGHT - 50

    self.dx = math.random(2) == 1 and -200 or 200
    self.dy = -200
end
