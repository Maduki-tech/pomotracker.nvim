-- main module file
local timer = require("pomotracker.timer")

---@class Config
---@field focus_time number Focus time in minutes
---@field break_time number Short break time in minutes
local config = {
    focus_time = 25,
    break_time = 5,
}

---@class Pomotracker
local M = {}

---@type Config
M.config = config

---@param args Config?
M.setup = function(args)
    M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.startTimer = function()
    timer.start()
end
M.stopTimer = function()
    timer.stop()
end
M.finishTimer = function()
    timer.finish()
end

return M
