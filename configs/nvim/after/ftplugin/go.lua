vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

-- vim.lsp.enable("golangci_lint")
-- vim.lsp.enable("gopls")
-- vim.lsp.enable("goimports")
-- vim.lsp.enable("templ")
-- vim.lsp.enable("go")
local U = require('manager.shortcuts')

U.map('n', '<leader>ca', '<cmd>GoCodeAction<CR>', "Code Actions")
U.map('v', '<leader>ca', "<cmd>'<,'>GoCodeAction<CR>", "Code Actions")



