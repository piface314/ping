local Const = require "src.const"
local initSpeed = Const.BALL_INIT_SPEED
local speedIncrement = Const.BALL_INC_SPEED
local wd, ht = Const.SCREEN_WD, Const.SCREEN_HT
local color = Const.BALL_COLOR

local Ball = {}
Ball.__index = Ball

local function getRandomInitVelocity()
    local angle = math.rad(love.math.random(-45, 45))
    local side = love.math.random() < 0.5 and -1 or 1
    return side * math.cos(angle), math.sin(angle)
end

function Ball.new(id, x, y, w, h, out)
    local vx, vy = getRandomInitVelocity()
    return setmetatable({
        id = id, x = x, y = y, w = w, h = h,
        vx = vx, vy = vy, sp = initSpeed,
        out = out
    }, Ball)
end

function Ball:update(dt, others)
    self:move(dt, others)
    self:collide(others)
end

function Ball:draw()
    love.graphics.setColor(color)
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

function Ball:addSpeed()
    self.sp = self.sp + speedIncrement
end

function Ball:getDirection()
    return self.vx, self.vy
end

function Ball:move(dt)
    self.x = self.x + self.sp * self.vx * dt
    self.y = self.y + self.sp * self.vy * dt
    if self.y < 0 then
        self.y = 0
        self.vy = -self.vy
    elseif self.y > ht - self.h then
        self.y = ht - self.h
        self.vy = -self.vy
    end
    if self.x + self.w < 0 then
        self:out(-1)
    elseif self.x > wd then
        self:out(1)
    end
end

local function rectCollision(ax, ay, aw, ah, bx, by, bw, bh)
    return ax <= bx + bw and bx <= ax + aw and ay <= by + bh and by <= ay + ah
end

function Ball:collide(others)
    local ox, oy = self.x + self.w / 2, self.y + self.h / 2
    for _, o in pairs(others) do
        if rectCollision(self.x, self.y, self.w, self.h, o.x, o.y, o.w, o.h) then
            self.vx, self.vy = o:hitAngle(ox, oy)
            self:addSpeed()
        end
    end
end

function Ball:setPosition(x, y)
    self.x, self.y = x, y
end

function Ball:setVelocity(vx, vy)
    if not vx or not vy then
        self.vx, self.vy = getRandomInitVelocity()
    else
        self.vx, self.vy = vx, vy
    end
end

function Ball:resetSpeed()
    self.sp = initSpeed
end

return Ball
