for _, f in pairs(vim.api.nvim_get_runtime_file("lua/colorschemes/*.lua", true)) do
    require('colorschemes.' .. vim.fn.fnamemodify(f, ":t:r"))
end
vim.cmd [[colorscheme ayu]]


