---@class Timer
---@field time number Current time in seconds
---@field running boolean Is the timer running
local M = {
    time = 0,
    running = false,
}

local countDownTimer = function()
    vim.defer_fn(function()
        if M.running and M.time > 0 then
            M.time = M.time - 1
        end
    end, 1000)
end

--- Starting the timer
--- @param focusMinutes number Focus time in minutes
M.start = function(focusMinutes)
    if M.running then
        return
    end

    M.time = focusMinutes
    M.running = true

    -- Start the countdown timer
    countDownTimer()
end

--- Stopping the timer and keep the current time
M.stop = function()
    if not M.running then
        return
    end

    M.running = false
end

--- Finish the timer and starting the next cycle
M.finish = function()
    if not M.running then
        return
    end

    M.time = 0
    M.running = false
end

--- Get the current timer time
--- @return number Current time in seconds
M.GetTimer = function()
    return M.time
end

return M
