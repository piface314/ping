local Const = require 'src.const'
local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT
local bw, bh = 8, 40
local gutter = 8

return function()
    local x, y = wd / 2 - bw / 2, -bh / 2
    love.graphics.setColor(1, 1, 1, 1)
    while y < ht do
        love.graphics.rectangle('fill', x, y, bw, bh)
        y = y + bh + gutter
    end
end
