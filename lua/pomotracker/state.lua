--- @alias STATE
---| "focus"
---| "break"

STATE = {
    FOCUS = "focus",
    BREAK = "break",
}

---@class State
---@field running boolean Is the timer running
---@field state string Current state of the timer (focus or break)
local M = {
    running = false,
    state = STATE.FOCUS,
}

--- @return STATE current state of the timer
M.getState = function()
    return M.state
end

--- @param state STATE
M.setState = function(state)
    M.state = state
end

--- @return boolean current state of the timer
M.getRunning = function()
    return M.running
end

--- @param isRunning boolean
M.setRunning = function(isRunning)
    M.running = isRunning
end

return M
