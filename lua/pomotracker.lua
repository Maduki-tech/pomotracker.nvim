-- main module file
local timer = require("pomotracker.timer")

---@class Config
---@field focus_time number Focus time in minutes
---@field break_time number Short break time in minutes
local config = {
    focus_time = 25 * 60,
    break_time = 5 * 60,
}

---@class Pomotracker
local M = {}

---@type Config
M.config = config

---@param args Config?
M.setup = function(args)
    M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.quickPomo = function()
    timer.start(M.config.focus_time)
end

M.taskPomo = function()
    local _ = vim.fn.input("Task Name: ")
    local taskTime = tonumber(vim.fn.input("Task Time (minutes): "))
    local _ = tonumber(vim.fn.input("Break Time (minutes): "))
    if taskTime then
        timer.start(taskTime * 60)
    end
end

M.stopPomo = function()
    timer.stop()
end

M.finish = function()
    timer.finish()
end

M.showTimer = function()
    local time = timer.GetTimer()
    local minutes = math.floor(time / 60)
    local seconds = time % 60
    return string.format("Timer: %02d:%02d", minutes, seconds)
end

return M
