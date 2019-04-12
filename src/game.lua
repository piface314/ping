local Background = require 'src.bg'
local GUI = require 'src.gui'
local Ball = require 'src.ball'
local Player = require 'src.player'
local Const = require 'src.const'

local Game = {}

local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT
local bs = Const.BALL_SIZE
local running = true
local wait = 0

local score = { 0, 0 }
local ball
local players = {}

function Game.load()
    ball = Ball.new(0, wd / 2 - bs / 2, ht / 2 - bs / 2, bs, bs, function(side)
        Game.handleBallOut(side)
    end)
    local pw, ph, xoff = Const.PLAYER_WD, Const.PLAYER_HT, Const.PLAYER_XOFFSET
    players[0] = Player.new(0, xoff, ht / 2 - ph / 2, pw, ph, 'w', 's')
    players[1] = Player.new(1, wd - xoff - pw, ht / 2 - ph / 2, pw, ph, 'i', 'k')
end

function Game.update(dt)
    if not running then return end
    for id, p in pairs(players) do
        p:update(dt)
    end
    if Game.handleWait(dt) then return end
    ball:update(dt, players)
end

function Game.draw()
    Background()
    GUI(score)
    if wait <= 0 then ball:draw() end
    for id, p in pairs(players) do
        p:draw()
    end
end

function Game.toggleRunning()
    running = not running
end

function Game.setWait(s)
    wait = s
end

function Game.handleWait(dt)
    if wait > 0 then
        wait = wait - dt
        return true
    else
        return false
    end
end

function Game.handleBallOut(side)
    if side < 0 then
        score[2] = score[2] + 1
    else
        score[1] = score[1] + 1
    end
    Game.setWait(2)
    ball:setPosition(wd / 2 - bs / 2, ht / 2 - bs / 2)
    ball:setVelocity()
    ball:resetSpeed()
end

return Game
