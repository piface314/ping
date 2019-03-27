local Const = require 'src.const'
local up = Const.DIR_UP
local down = Const.DIR_DOWN
local color = Const.PLAYER_COLOR

local Player = {}
Player.__index = Player

function Player.new(id, x, y, w, h)
    return setmetatable({ id = id, x = x, y = y, w = w, h = h }, Player)
end

function Player:update(dt)

end

function Player:draw()
    love.graphics.setColor(color)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

function Player:control(dt, dir)

end

return Player
