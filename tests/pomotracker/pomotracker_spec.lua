local pomo = require("pomotracker")
local assert = require("luassert")

describe("setup", function()
    before_each(function()
        pomo.finish()
    end)

    after_each(function()
        pomo.finish()
    end)
    it("sets default config", function()
        pomo.setup()
        assert.are.same(pomo.config.focus_time, 25 * 60)
        assert.are.same(pomo.config.break_time, 5 * 60)
    end)

    it("overrides default config", function()
        pomo.setup({ focus_time = 30 * 60, break_time = 10 * 60 })
        assert.are.same(pomo.config.focus_time, 30 * 60)
        assert.are.same(pomo.config.break_time, 10 * 60)
    end)
end)

describe("quickPomo", function()
    before_each(function()
        pomo.finish()
    end)

    after_each(function()
        pomo.finish()
    end)

    it("starts the timer with focus time", function()
        pomo.setup({ focus_time = 20 * 60, break_time = 5 * 60 })
        pomo.quickPomo()
        local time = pomo.showTimer()
        assert.are.same(time, "Timer: 20:00")
    end)

    it("does not start a new timer if one is already running", function()
        pomo.setup({ focus_time = 20 * 60, break_time = 5 * 60 })
        pomo.quickPomo()
        local timeBefore = pomo.showTimer()
        pomo.quickPomo() -- Attempt to start another timer
        local timeAfter = pomo.showTimer()
        assert.are.same(timeBefore, timeAfter) -- Timer should not reset
    end)

    it("should count down the timer", function()
        pomo.setup({ focus_time = 1, break_time = 5 * 60 }) -- Set focus time to 1 second for testing
        pomo.quickPomo()
        vim.wait(1500) -- Wait for 1.5 seconds to ensure the timer has counted down
        local time = pomo.showTimer()
        assert.are.same(time, "Timer: 00:00") -- Timer should have finished
    end)
end)

describe("finish", function()
    before_each(function()
        pomo.finish()
    end)

    after_each(function()
        pomo.finish()
    end)
    it("resets the timer", function()
        pomo.quickPomo()
        pomo.finish()
        local time = pomo.showTimer()
        assert.are.same(time, "Timer: 00:00")
    end)
end)

describe("showTimer", function()
    before_each(function()
        pomo.finish()
    end)

    after_each(function()
        pomo.finish()
    end)
    it("displays the current timer time", function()
        pomo.setup({ focus_time = 15 * 60, break_time = 5 * 60 })
        pomo.quickPomo()
        local time = pomo.showTimer()
        assert.are.same(time, "Timer: 15:00")
    end)
end)

describe("taskPomo", function()
    local original_input

    before_each(function()
        original_input = vim.fn.input
        pomo.finish()
    end)

    after_each(function()
        vim.fn.input = original_input
        pomo.finish()
    end)

    it("starts timer with user input", function()
        local inputs = { "My Task", "25", "5" }
        local call_count = 0

        --- @diagnostic disable-next-line: duplicate-set-field
        vim.fn.input = function()
            call_count = call_count + 1
            return inputs[call_count]
        end

        pomo.taskPomo()

        local time = pomo.showTimer()
        assert.are.same(time, "Timer: 25:00")
    end)

    it("handles invalid task time", function()
        local inputs = { "My Task", "not a number", "5" }
        local call_count = 0

        --- @diagnostic disable-next-line: duplicate-set-field
        vim.fn.input = function()
            call_count = call_count + 1
            return inputs[call_count]
        end

        pomo.taskPomo()

        local time = pomo.showTimer()
        assert.are.same(time, "Timer: 00:00")
    end)
end)
