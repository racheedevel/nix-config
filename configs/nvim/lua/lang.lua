for _, f in pairs(vim.api.nvim_get_runtime_file("lua/lang_mods/*.lua", true)) do
    require('lang_mods.' .. vim.fn.fnamemodify(f, ":t:r"))
end
