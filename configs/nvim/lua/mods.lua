for _, f in pairs(vim.api.nvim_get_runtime_file("lua/mods/*.lua", true)) do
    require('mods.' .. vim.fn.fnamemodify(f, ":t:r"))
end
