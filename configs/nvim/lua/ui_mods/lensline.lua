vim.pack.add({
    {
        src = "https://github.com/oribarilan/lensline.nvim",
        version = vim.version.range("1.*"),
    }
})

local lensline = require('lensline')
lensline.setup()
lensline.enable()
