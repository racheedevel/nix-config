vim.pack.add({
    {
        src = "https://github.com/L3MON4D3/LuaSnip",
        version = vim.version.range('2.*')
    }
}
)
vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("<=2")
    }
}
)

local blink = require('blink.cmp')

blink.setup({
    sources = {
        providers = {
            cmdline = {
                -- ignores cmdline completions when executing shell commands
                enabled = function()
                    return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                end
            },
            lsp = {
                name = 'LSP',
                module = 'blink.cmp.sources.lsp',
                transform_items = function(_, items)
                    return vim.tbl_filter(function(item)
                        return item.kind ~= require('blink.cmp.types').CompletionItemKind.Keyword
                    end, items)
                end,
            },
        },
    },

    snippets = { preset = "luasnip" },

    completion = {
        keyword = {
            range = 'full',
        },
        list = {
            selection = {
                preselect = false,
                auto_insert = true,
            }
        },
        menu = {
            draw = {
                components = {
                    kind_icon = {
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                        -- (optional) use highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    },
                    kind = {
                        -- (optional) use highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    }
                }
            }
        }
    },

    keymap = {
        preset = 'enter',
        ['<C-n>'] = {},
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = {},
        ['<C-k>'] = { 'select_prev', 'fallback' },
    },

    fuzzy = {
        sorts = {
            'exact',
            -- defaults
            'score',
            'sort_text',
        },
    },



})
