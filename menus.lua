menus = Class {}

function menus.start()
    love.graphics.printf('Hit the ball to destroy all the bricks!', 0, 64, VIRTUAL_WIDTH, 'center')
end

function menus.serve()
    love.graphics.printf('Press enter to server the bal!', 0, 64, VIRTUAL_WIDTH, 'center')
end

function menus.win()
    love.graphics.setFont(endFont)
    love.graphics.printf('You won!', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
end

function menus.lose()
    love.graphics.setFont(endFont)
    love.graphics.printf('You lost :(', 0, 64, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
end
