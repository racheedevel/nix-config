local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

-- Set colorscheme
autocmd("VimEnter", {
    callback = function()
        -- stylua: ignore start
        vim.cmd [[colorscheme ayu]]
        -- stylua: ignore end
    end,
})


-- Highlight after yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Next 2: Dashboard if all buffers are empty
autocmd("BufDelete", {
    group = vim.api.nvim_create_augroup("bufdelpost_autocmd", {}),
    desc = "BufDeletePost User autocmd",
    callback = function()
        vim.schedule(function()
            vim.api.nvim_exec_autocmds("User", {
                pattern = "BufDeletePost",
            })
        end)
    end,
})


autocmd("User", {
    pattern = "BufDeletePost",
    group = vim.api.nvim_create_augroup("dashboard_delete_buffers", {}),
    desc = "Open Dashboard when no available buffers",
    callback = function(ev)
        local deleted_name = vim.api.nvim_buf_get_name(ev.buf)
        local deleted_ft = vim.api.nvim_get_option_value("filetype", { buf = ev.buf })
        local deleted_bt = vim.api.nvim_get_option_value("buftype", { buf = ev.buf })
        local dashboard_on_empty = deleted_name == "" and deleted_ft == "" and deleted_bt == ""

        if dashboard_on_empty then
            vim.cmd("redraw!")
        end
    end,
})

autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local line = vim.fn.line("'\"")
        if
            line > 1
            and line <= vim.fn.line("$")
            and vim.bo.filetype ~= "commit"
            and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
        then
            vim.cmd('normal! g`"')
        end
    end,
})

autocmd("BufFilePost", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("empty_ft_as_md_or_bash", {}),
    callback = function()
        if vim.bo.filetype == "" then
            local filepath = vim.api.nvim_buf_get_name(0)
            if filepath:match("scratchpad") or filepath:match("note") then
                vim.bo.filetype = 'markdown'
            else
                vim.bo.filetype = 'bash'
            end
        end
    end,
})

usercmd("OpenPdf", function()
    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath:match("%.typ$") then
        local pdf_path = filepath:gsub("%.typ$", ".pdf")
        vim.system({ "zathura", pdf_path })
    end
end, {})


usercmd("UpdatePlugins", function()
    local plugins = vim.pack.get()
    local names = {}

    for _, plugin in ipairs(plugins) do
        if plugin.spec and plugin.spec.name then
            table.insert(names, plugin.spec.name)
        end
    end

    vim.pack.update(names)
end, {})

-- Create keymapping
-- LspAttach: After an LSP Client performs "initialize" and attaches to a buffer.
autocmd("LspAttach", {
    callback = function(args)
        local keymap = vim.keymap
        local lsp = vim.lsp

        keymap.set("n", "<leader>cR", function()
            lsp.buf.references()
        end, { noremap = true, silent = true, desc = "References" })

        keymap.set("n", "<leader>cd", function()
            lsp.buf.definition()
        end, { noremap = true, silent = true, desc = "Definition" })

        keymap.set("n", "<leader>ci", function()
            lsp.buf.implementation()
        end, { noremap = true, silent = true, desc = "Implementation" })

        keymap.set("n", "<leader>cr", function()
            lsp.buf.rename()
        end, { noremap = true, silent = true, desc = "Rename" })

        keymap.set("n", "K", function()
            lsp.buf.hover()
        end, { noremap = true, silent = true, desc = "Hover" })

        keymap.set("n", "<leader>cf", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end, { noremap = true, silent = true, desc = "Format" })
    end,
})
