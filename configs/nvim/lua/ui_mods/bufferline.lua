vim.pack.add({ { src = "https://github.com/akinsho/bufferline.nvim" } })
local bufferline = require("bufferline")
bufferline.setup({
    options = {
        mode = "buffers", -- could be tabs?
        -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
        -- themable = true,
        -- highlights = {
        -- 	tab = {
        -- 		bg = "#424552",
        -- 		fg = "#2D2D2D",
        -- 	},
        -- 	tab_selected = {
        -- 		bg = "#38b4da",
        -- 		fg = "#2d3039",
        -- 		italic = true,
        -- 	},
        -- 	tab_separator = {
        -- 		bg = "#424552",
        -- 		fg = "#2D2D2D",
        -- 	},
        -- 	tab_separator_selected = {
        -- 		fg = "#cfd2dd",
        -- 		bg = "#292b32",
        -- 	},
        -- 	close_button = {
        -- 		bg = "#6f1313",
        -- 		fg = "#b9c3df",
        -- 	},
        -- },
        numbers = "ordinal",
        close_command = "bdelete! %d",
        right_mouse_command = "vert sbuffer %d",
        left_mouse_command = "buffer %d",
        max_name_length = 18,
        max_prefix_length = 10,
        truncate_names = true,
        diagnostics = "nvim_lsp",
        diagnostics_update_on_event = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "Files",
                highlight = "Directory",
                separator = true,
            },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = "thin",
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
        indicator = {
            style = "underline",
        },
        hover = {
            enabled = true,
            reveal = { "close" },
        },
        sort_by = "insert_after_current",
    },
})
