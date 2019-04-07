local Const = require "src.const"
function love.conf(t)
    t.title = 'Ping'
    t.window.width = Const.SCREEN_WD
    t.window.height = Const.SCREEN_HT
    t.modules.physics = false
    t.console = true
    t.window.resizable = false
    t.window.fullscreen = false
end
