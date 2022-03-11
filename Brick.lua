Brick = Class {}

function Brick:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.red = math.random(0, 255) / 255
    self.green = math.random(0, 255) / 255
    self.blue = math.random(0, 255) / 255
end

function Brick:collides()
    if ball.y <= self.y + self.height and ball.y >= self.y and ball.x + ball.width >= self.x and ball.x + ball.width <=
     self.x + self.width then
        return true
    end

    return false

end

function Brick:render()
    love.graphics.setColor(self.red, self.green, self.blue, 1)

    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1, 1)
end
