-- vim.api.nvim_create_user_command(
--     "MyFirstFunction",
--     require("pomotracker").hello,
--     {}
-- )

vim.api.nvim_create_user_command(
    "PomoQuick",
    require("pomotracker").quickPomo,
    {}
)

vim.api.nvim_create_user_command(
    "PomoTimer",
    require("pomotracker").showTimer,
    {}
)

vim.api.nvim_create_user_command(
    "PomoStop",
    require("pomotracker").stopPomo,
    {}
)

vim.api.nvim_create_user_command(
    "PomoFinish",
    require("pomotracker").finish,
    {}
)

vim.api.nvim_create_user_command(
    "PomoTask",
    require("pomotracker").taskPomo,
    {}
)
