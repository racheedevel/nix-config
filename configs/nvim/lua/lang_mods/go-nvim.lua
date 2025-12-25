vim.pack.add({ "https://github.com/ray-x/guihua.lua", "https://github.com/neovim/nvim-lspconfig", { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })
vim.pack.add({ "https://github.com/ray-x/go.nvim" })
require("go").setup({
    max_line_len = 78,
    tag_transform = true,
    tag_options = 'json=omitempty',
})
-- event = {"CmdlineEnter"},
-- ft = {"go", "gomod" },
