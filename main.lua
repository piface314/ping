local Game = require 'src.game'

function love.load()
    Game.load()
end

function love.update(dt)
    Game.update(dt)
end

function love.draw()
    Game.draw()
end

function love.keyreleased(key)
    Game.keyreleased(key)
end
