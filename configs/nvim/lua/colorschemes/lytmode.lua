vim.pack.add({ "https://github.com/github-main-user/lytmode.nvim" })
local c = require("lytmode.colors")
require("lytmode").setup({
    -- Enable transparent background
    transparent = false,

    -- Enable italic comment
    italic_comments = true,

    -- Enable italic inlay type hints
    italic_inlayhints = true,

    -- Underline `@markup.link.*` variants
    underline_links = true,

    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,

    -- Apply theme colors to terminal
    terminal_colors = true,

    -- Override colors (see ./lua/lytmode/colors.lua)
    color_overrides = {
        vscLineNumber = "#FFFFFF",
    },

    -- Override highlight groups (see ./lua/lytmode/theme.lua)
    group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring lytmode.colors!
        Cursor = { fg = c.vscDarkBlue, bg = c.lytLightGreen, bold = true },
        TabLineSel = { fg = c.lytFront, bg = c.lytTabCurrent, italic = true },
        WildMenu = { fg = c.vscDarkBlue, bg = c.lytLightGreen, bold = true },
    },
})
