for _, f in pairs(vim.api.nvim_get_runtime_file("lua/ui_mods/*.lua", true)) do
    require('ui_mods.' .. vim.fn.fnamemodify(f, ":t:r"))
end
