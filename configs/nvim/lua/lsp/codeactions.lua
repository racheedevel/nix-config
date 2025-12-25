local M = require 'manager.plugin'
M.add_plugin({

    "rachartier/tiny-code-action.nvim",
    no_setup = true,
})

require('tiny-code-action').setup {
    backend = "vim",
    picker = {
        "buffer",
        opts = {
            hotkeys = true,                   -- Enable hotkeys for quick selection of actions
            hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
            auto_preview = false,             -- Enable or disable automatic preview
            auto_accept = false,              -- Automatically accept the selected action (with hotkeys)
            position = "cursor",              -- Position of the picker window
            winborder = "single",             -- Border style for picker and preview windows
            keymaps = {
                preview = "K",                -- Key to show preview
                close = { "q", "<Esc>" },     -- Keys to close the window (can be string or table)
                select = "<CR>",              -- Keys to select action (can be string or table)
            },
            custom_keys = {
                { key = 'm', pattern = 'Fill match arms' },
                { key = 'r', pattern = 'Rename.*' }, -- Lua pattern matching
            },
        },
    },
    signs = {
        quickfix = { "", { link = "DiagnosticWarning" } },
        others = { "", { link = "DiagnosticWarning" } },
        refactor = { "", { link = "DiagnosticInfo" } },
        ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
        ["refactor.extract"] = { "", { link = "DiagnosticError" } },
        ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
        ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
        ["source"] = { "", { link = "DiagnosticError" } },
        ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
        ["codeAction"] = { "", { link = "DiagnosticWarning" } },
    },
}

vim.keymap.set({ "n", "x" }, "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
