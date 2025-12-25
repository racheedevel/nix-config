vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons", "https://github.com/frankroeder/parrot.nvim" })
vim.pack.add({ { src = "https://github.com/nvim-lualine/lualine.nvim" } })

-- Keymap name
local function keymap()
    if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
        return '⌨ ' .. vim.b.keymap_name
    end
    return ''
end

local trouble = require("trouble")
local symbols = trouble.statusline({
    mode = "lsp_document_symbols",
    groups = {},
    title = false,
    filter = { range = true },
    format = "{kind_icon}{symbol.name:Normal}",
    -- The following line is needed to fix the background color
    -- Set it to the lualine section you want to use
    hl_group = "lualine_c_normal",
})

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        -- component_separators = { left = "", right = "" },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { "NvimTree" },
            winbar = { "NvimTree" },
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = true,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        },
    },
    sections = {
        lualine_a = {
            {
                "mode",
                icons_enabled = true,
                -- on_click = function()
                --   return
                -- end,
                padding = 1,
            },
            -- {
            --   'datetime',
            --   style = "%H:%M",
            -- },
            -- {
            --   'encoding',
            --   show_bomb = true,
            -- },
            "tabs",
        },
        lualine_b = {
            {
                "searchcount",
                maxcount = 99,
                timeout = 500,
            },
            "selectioncount",
            {
                'branch',
                icon = '',
            },
        },
        lualine_c = {
            {
                "filename",
                path = 1,
                file_status = true,
                symbols = {
                    modified = "[+/-]",
                    readonly = "[!]",
                    unnamed = "[?]",
                    newfile = "[*]",
                },
            },
        },
        lualine_x = {},
        lualine_y = {
            {
                "filetype",
                colored = true,
                icon_only = false,
                -- icon = {
                --     align = "right",
                -- },
            },
            '%l:%c <%p%%>'
        },
        lualine_z = {
            {
                "diagnostics",
                sources = { "nvim_lsp" },
                sections = { "error", "warn" },
                symbols = { error = "[E]", warn = "[W]", info = "[I]", hint = "[H]" },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            },
            {
                symbols.get,
                cond = symbols.has,
            }
        },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = { "branch" },
        lualine_x = {},
        lualine_y = { "location" },
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { "trouble", "fzf", "mason", "toggleterm" },
})
