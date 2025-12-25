local sup = "/x/r/lua/proto"
if vim.fn.isdirectory(sup) == 1 then
    vim.opt.rtp:prepend(sup)
end
pcall(vim.loader.enable)

require("runtime_mods")

require("config.settings")
require("config.terminals")

require('colorscheme')
require('lsp.blink')
require('lsp.codeactions')
require('lsp.cfg')
-- require('lsp.autocomplete')
require('mods')
require('lang')
require('ui')
require("config.keybinds")
-- require("config.diagnostics")
-- require("prefs.rubocop")
require("config.autocmds")

vim.o.foldenable = false
