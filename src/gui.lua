local Const = require 'src.const'
local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT
local colorScore, colorPause = Const.SCORE_COLOR, Const.PAUSE_COLOR
local colorWin = Const.WIN_COLOR
local pauseBlinkTime = Const.PAUSE_BLINK

local fontScore, fontGUI

local padding = 20
local wd2 = wd / 2
local pauseActive = false
local pauseY

local GUI = {}

function GUI.load()
    fontScore = love.graphics.newFont('fonts/pong-score.ttf', Const.SCORE_SIZE)
    fontGUI = love.graphics.newFont('fonts/8bit.ttf', Const.TEXT_SIZE)
    pauseY = ht / 2 - fontGUI:getHeight() / 2
end

local interval
function GUI.update(dt, running)
    if running then
        interval = nil
    else
        if not interval then
            interval = pauseBlinkTime
            pauseActive = true
        end
        if interval <= 0 then
            interval = pauseBlinkTime
            pauseActive = not pauseActive
        else
            interval = interval - dt
        end
    end
end

function GUI.score(score)
    love.graphics.setColor(colorScore)
    love.graphics.setFont(fontScore)
    love.graphics.printf(score[1], 0,   padding, wd2, 'center')
    love.graphics.printf(score[2], wd2, padding, wd2, 'center')
end

function GUI.paused(running)
    if not running and pauseActive then
        love.graphics.setColor(colorPause)
        love.graphics.setFont(fontGUI)
        love.graphics.printf("PAUSE", 0, pauseY, wd, 'center')
    end
end

function GUI.win(player)
    love.graphics.setColor(colorWin)
    love.graphics.setFont(fontGUI)
    love.graphics.printf(("Player %d WINS!!!"):format(player), 0, pauseY, wd, 'center')
end

return GUI
