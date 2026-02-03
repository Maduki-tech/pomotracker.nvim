-- main module file
local module = require("pomotracker.module")

---@class Config
---@field focus_time number Focus time in minutes
---@field break_time number Short break time in minutes
local config = {
    focus_time = 25,
    break_time = 5,
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
    M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.hello = function()
    return module.my_first_function(M.config.opt)
end

return M
