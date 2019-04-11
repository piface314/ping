local Background = require 'src.bg'
local GUI = require 'src.gui'
local Ball = require 'src.ball'
local Player = require 'src.player'
local Const = require 'src.const'

local Game = {}

local score = { 0, 0 }
local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT
local running = true

local ball
local players = {}

function Game.load()
    local bs = Const.BALL_SIZE
    ball = Ball.new(0, wd / 2 - bs / 2, ht / 2 - bs / 2, bs, bs)
    local pw, ph, xoff = Const.PLAYER_WD, Const.PLAYER_HT, Const.PLAYER_XOFFSET
    players[0] = Player.new(0, xoff, ht / 2 - ph / 2, pw, ph, 'w', 's')
    players[1] = Player.new(1, wd - xoff - pw, ht / 2 - ph / 2, pw, ph, 'i', 'k')
end

function Game.update(dt)
    if not running then return end
    ball:update(dt, players)
    for id, p in pairs(players) do
        p:update(dt)
    end
end

function Game.draw()
    Background()
    ball:draw()
    for id, p in pairs(players) do
        p:draw()
    end
end

function Game.toggleRunning()
    running = not running
end

return Game
