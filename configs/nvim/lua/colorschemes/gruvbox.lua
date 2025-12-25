vim.pack.add({ { src = "https://github.com/ellisonleao/gruvbox.nvim" } })
require("gruvbox").setup({
    terminal_colors = true,
    undercurl = true,
    underline = false,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = true,
    contrast = "soft", -- or hard/soft/""
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})
