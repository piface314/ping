local Const = require 'src.const'
local color = Const.PLAYER_COLOR
local speed = Const.PLAYER_BASE_SPEED
local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT

local Player = {}
Player.__index = Player

function Player.new(id, x, y, w, h, keyup, keydown)
    return setmetatable({
        id = id,
        x = x, y = y,
        w = w, h = h,
        keyup = keyup, keydown = keydown,
        v = 0
    }, Player)
end

function Player:update(dt)
    self:control()
    self:move(dt)
end

function Player:draw()
    love.graphics.setColor(color)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

function Player:control()
    local up = love.keyboard.isDown(self.keyup)
    local down = love.keyboard.isDown(self.keydown)
    if up and not down then
        self.v = -speed
    elseif down and not up then
        self.v = speed
    else
        self.v = 0
    end
end

function Player:move(dt)
    self.y = self.y + self.v * dt
    if self.y < 0 then
        self.y = 0
    elseif self.y > ht - self.h then
        self.y = ht - self.h
    end
end

function Player:hitAngle(x, y)
    local ox, oy = self.x + self.w / 2, self.y + self.h / 2
    ox = x < ox and ox + self.w * 2 or ox - self.w * 2
    local vx, vy = x - ox, y - oy
    local d = math.sqrt(vx * vx + vy * vy)
    return vx / d, vy / d
end

return Player
