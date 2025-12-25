vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
local ibl = require("ibl")
ibl.setup {
    debounce = 300,
    indent = {
        -- highlight = "Comment",
        char = "|",
    },
    scope = {
        -- char = "┋",
        char = "|",
        highlight = { "Label" },
        show_start = false,
        show_end = false,
    },
    exclude = {
        filetypes = {
            "dashboard",
        },
        buftypes = { "dashboard" },
    },
}
