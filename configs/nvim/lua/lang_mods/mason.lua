vim.pack.add({ "https://github.com/hrsh7th/nvim-cmp" })
vim.pack.add({ { src = "https://github.com/mason-org/mason.nvim" } })

require("mason").setup()
-- local lspconfigs = vim.lsp._enabled_configs
-- for name, cfg in pairs(lspconfigs) do
    -- local cmd = cfg.resolved_config.cmd[1]
    -- if vim.fn.executable(cmd) == 0 then
        -- vim.cmd("MasonInstall " .. name)
    -- end
    -- vim.lsp.enable(name)
-- end

-- non lsp packages
-- local packages = {}
-- for cmd, pkg in pairs(packages) do
--     if vim.fn.executable(cmd) == 0 then
--         vim.cmd("MasonInstall " .. pkg)
--     end
-- end
