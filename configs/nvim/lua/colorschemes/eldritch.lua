vim.pack.add({ { src = "https://github.com/eldritch-theme/eldritch.nvim" } })
require("eldritch").setup({
    palette = "darker",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = {
            italic = true,
        },
        keywords = {
            bold = true,
        },
        functions = {
            italic = true,
        },
    },
})
