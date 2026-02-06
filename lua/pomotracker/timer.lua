local async = require("plenary.async")

---@class Timer
---@field time number Current time in seconds
---@field break_time number Break time in seconds
---@field focus_time number Focus time in seconds
local M = {
    time = 0,
    break_time = 0,
    focus_time = 0,
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
--- @param breakMinutes number Break time in minutes
M.start = function(focusMinutes, breakMinutes)
    if M.running then
        return
    end

    M.time = focusMinutes
    M.running = true
    M.focus_time = focusMinutes
    M.break_time = breakMinutes

    -- Start the countdown timer
    -- FIX: This is not the best way to implement a timer, but it works for now. We can improve this later by using a more accurate timer implementation.
    async.run(function()
        while M.running and M.time > 0 do
            countDownTimer()
            async.util.sleep(1000) -- Sleep for 1 second
        end
        if M.running and M.time <= 0 then
            M.running = false
            vim.notify(
                "Pomodoro finished! Break will start in 10 seconds.",
                vim.log.levels.INFO,
                {}
            )
            vim.defer_fn(function()
                -- TODO: Use the config here
                M.start(5)
            end, 10000)
        end
    end, function(err)
        if err then
            vim.notify(
                "Error starting PomodoroTimer ",
                vim.log.levels.ERROR,
                {}
            )
        end
    end)
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
