local Background = require 'src.bg'
local GUI = require 'src.gui'
local Ball = require 'src.ball'
local Player = require 'src.player'
local Const = require 'src.const'
local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT
local bs = Const.BALL_SIZE
local winScore = Const.WIN_SCORE
local keyPause = Const.KEY_PAUSE
local keyUP1, keyDP1 = Const.KEY_UP_PLAYER1, Const.KEY_DW_PLAYER1
local keyUP2, keyDP2 = Const.KEY_UP_PLAYER2, Const.KEY_DW_PLAYER2

local Game = {}

local running = true
local wait = 0
local waitTriggers = {}

local score = { 0, 0 }
local winner
local ball
local players = {}

function Game.load()
    GUI.load()
    ball = Ball.new(0, wd / 2 - bs / 2, ht / 2 - bs / 2, bs, bs, function(side)
        Game.handleBallOut(side)
    end)
    local pw, ph, xoff = Const.PLAYER_WD, Const.PLAYER_HT, Const.PLAYER_XOFFSET
    players[1] = Player.new(1, xoff, ht / 2 - ph / 2, pw, ph, keyUP1, keyDP1)
    players[2] = Player.new(2, wd - xoff - pw, ht / 2 - ph / 2, pw, ph, keyUP2, keyDP2)
end

function Game.update(dt)
    GUI.update(dt, running)
    if not running then return end
    for id, p in pairs(players) do
        p:update(dt)
    end
    if Game.handleWait(dt) then return end
    ball:update(dt, players)
end

function Game.draw()
    Background()
    GUI.score(score)
    if wait <= 0 then ball:draw() end
    for id, p in pairs(players) do
        p:draw()
    end
    GUI.paused(running)
    if winner then
        GUI.win(winner)
    end
end

function Game.keyreleased(key)
    if key == keyPause then
        running = not running
    end
end

function Game.setWait(s, trigger)
    wait = s
    if trigger then
        waitTriggers[trigger] = trigger
    end
end

function Game.handleWait(dt)
    if wait > 0 then
        wait = wait - dt
        if wait <= 0 then
            for _, t in pairs(waitTriggers) do
                t()
                waitTriggers[t] = nil
            end
        end
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
    local p = Game.checkWin()
    if p then
        winner = p
        Game.setWait(5, Game.reset)
    else
        Game.setWait(2)
    end
    ball:setPosition(wd / 2 - bs / 2, ht / 2 - bs / 2)
    ball:setVelocity()
    ball:resetSpeed()
end

function Game.checkWin()
    if score[1] == winScore then
        return 1
    elseif score [2] == winScore then
        return 2
    else
        return nil
    end
end

function Game.reset()
    winner = nil
    score[1], score[2] = 0, 0
end

return Game
