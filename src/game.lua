local Background = require 'src.bg'
local GUI = require 'src.gui'
local Ball = require 'src.ball'
local Player = require 'src.player'

local Game = {}

local score = {0, 0}
local wd, ht
local running = false

local ball
local players

function Game.load()
    wd, ht = love.graphics.getDimensions()
end

function Game.update(dt)

end

function Game.draw()
    Background()
end

function Game.toggleRunning()
    running = not running
end

return Game
