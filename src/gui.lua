local Const = require 'src.const'
local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT
local font = love.graphics.newFont('fonts/pong-score.ttf', 64)

local padding = 20
local wd2 = wd / 2

return function(score)
    love.graphics.setFont(font)
    love.graphics.printf(score[1], 0,   padding, wd2, 'center')
    love.graphics.printf(score[2], wd2, padding, wd2, 'center')
end
