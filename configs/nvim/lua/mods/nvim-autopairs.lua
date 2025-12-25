vim.pack.add({ { src = "https://github.com/windwp/nvim-autopairs" } })
-- event = "InsertEnter",
require('nvim-autopairs').setup {
    disable_in_visualblock = true,
    disable_in_replace_mode = true,
    fast_wrap = {},
}
vim.pack.add({ { src = "https://github.com/windwp/nvim-ts-autotag" } })
-- event = "InsertEnter",
require('nvim-ts-autotag').setup({
    opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
    },
})
