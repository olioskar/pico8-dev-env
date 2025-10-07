pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- Name: My Cool Game
-- Author: @coolgamedev

function _init()
    -- code here happens one time
    -- when your game starts.
end

function _update()
    -- code here happens 30 times
    -- every second.
end

function _draw()
    -- code here also happens 30
    -- times every second, but
    -- after _update() happens.
    cls()
    print("Hello PICO-8!", 40, 64, 7)
end