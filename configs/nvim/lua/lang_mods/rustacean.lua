vim.pack.add({ { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range('6') } })

vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ['rust-analyzer'] = {
                cargo = {
                    features = "all"
                }
            }
        }
    }

}

vim.pack.add({ { src = "https://github.com/saecki/crates.nvim", version = 'stable' } })
require('crates').setup({
    lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
    }
})
