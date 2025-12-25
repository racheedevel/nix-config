-- local M = require("manager.shortcuts")
-- vim.api.nvim_create_autocmd("TermOpen", {
--     pattern = "*",
--     callback = function()
--         vim.opt_local.number = false
--         vim.opt_local.relativenumber = false
--         vim.opt_local.signcolumn = "no"
--         vim.opt_local.cursorline = false
--     end,
-- })

-- M.map("t", "<Esc>", [[<C-\><C-n>]])
-- M.map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
-- M.map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
-- M.map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
-- M.map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- local T = require('manager.term')

-- local function default_shell()
--     local sh = vim.o.shell or "sh"
--     return sh
-- end
-- local function open_right_term()
--     T.open_in_area({ area = "right", size = T.area_size_pct(20) })
-- end

-- local function open_bottom_term()
--     T.open_in_area({ area = "bottom", size = T.area_size_pct(20) })
-- end

-- local function split_same_area_term()
--     T.split_in_term_area()
-- end

-- vim.api.nvim_create_user_command("Trm", function(ctx)
--     local args = ctx.fargs
--     if #args == 0 then
--         open_bottom_term()
--         return
--     end

--     local mode = args[1]
--     local cmdline
--     local persist

--     if mode == 'x' or mode == 'p' then
--         cmdline = table.concat(vim.list_slice(args, 2), " ")
--         persist = (mode == "p")
--     else
--         cmdline = table.concat(args, " ")
--         persist = true
--     end

--     T.open_in_area({
--         area = "bottom",
--         size = { pct = 20 },
--         cmd = { default_shell(), "-lc", cmdline },
--         persist = persist,
--         insert = true,
--         on_exit = function(code, _)
--             vim.notify(("Trm exited with code %d"):format(code),
--                 (code == 0) and vim.log.levels.INFO or vim.log.levels.ERROR)
--         end,
--     })
-- end, { nargs = "+" }
-- )

-- vim.api.nvim_create_user_command("DockerBuild", function()
--     T.open_in_area({
--         area = "right",
--         size = { pct = 20 },
--         cwd = T.root_cwd(),
--         cmd = { default_shell(), "-lc", "docker build ." },
--         persist = false,
--         insert = true,
--         on_exit = function(code, _)
--             vim.notify(("Docker build process exit code %d"):format(code),
--                 (code == 0) and vim.log.levels.INFO or vim.log.levels.ERROR)
--         end,
--     })
-- end, {})

-- M.map("n", "<leader>tv", open_right_term, "Open terminal in vsplit")
-- M.map("n", "<leader>th", open_bottom_term, "Open terminal in hsplit")
-- M.map( "t", "<localleader>t", function()
--     split_same_area_term()
-- end, "Split current terminal area")
