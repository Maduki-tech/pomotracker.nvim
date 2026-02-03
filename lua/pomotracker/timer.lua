---@class Timer
---@field time number Current time in seconds
---@field running boolean Is the timer running
local M = {
    time = 0,
    running = false,
}

--- Starting the timer
M.start = function() end

--- Stopping the timer and keep the current time
M.stop = function() end

--- Finish the timer and starting the next cycle
M.finish = function() end

return M
