vim.pack.add({ { src = "https://github.com/stevearc/conform.nvim" } })
local conform = require("conform")
conform.setup({
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt", "golangci-lint", "goimports" },
        rust = { "rustfmt" },
        ruby = { "rubocop" },
        yaml = { "yamlfmt" },
        javascript = { "biome-check" },
        typescript = { "biome-check" },
        typescriptreact = { "biome-check" },
        javascriptreact = { "biome-check" },
        python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
                return { "ruff_format" }
            else
                return { "pyright", "black" }
            end
        end,
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    -- format_on_save = {
    --     lsp_format = "fallback",
    --     timeout_ms = 500,
    -- },
})

vim.keymap.set("n", "<leader>f", function() conform.format({ async = true, lsp_format = "never" }) end, { desc = "[F]ormat buffer", })
