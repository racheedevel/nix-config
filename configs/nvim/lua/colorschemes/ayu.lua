vim.pack.add({ "https://github.com/Shatur/neovim-ayu" })
local colors = require('ayu.colors')
require("ayu").setup({
    mirage = false,
    terminal = true,
    overrides = {
        MatchParen = { fg = colors.entity, bold = true }
    },
})
