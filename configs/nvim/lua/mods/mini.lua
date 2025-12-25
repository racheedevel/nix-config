vim.pack.add({ { src = "https://github.com/echasnovski/mini.nvim" } })
require("mini.ai").setup()
require('mini.move').setup()
require('mini.notify').setup()
require("mini.comment").setup({
    options = {
        -- custom_commentstring = nil,
        ignore_blank_line = true,
        start_of_line = false,
        pad_comment_parts = false,
    },
    mappings = {
        -- Normal and visual modes
        comment = "<M-/>",
        -- Toggle comment on current line
        comment_line = "<M-/>",
        -- Toggle comment on visual selection
        comment_visual = "<M-/>",
        -- Select 'comment' textobject (d<bind> to delete comment block)
        textobject = "gc",
    },
    hooks = {
        -- Before successful commenting. Does nothing by default.
        pre = function() end,
        -- After successful commenting. Does nothing by default.
        post = function() end,
    },
})

require('mini.icons').setup()
