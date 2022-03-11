Paddle = Class {}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dx = 0
end

function Paddle:update(dt)
    if love.keyboard.isDown('d') or love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, math.floor(self.x + self.dx * dt))
    elseif self.dx > 0 then
        self.x = math.min(VIRTUAL_WIDTH - 50, math.floor(self.x + self.dx * dt))
    end
end

function Paddle:reset()
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.dx = 0
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
