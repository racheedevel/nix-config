local o = vim.opt
-- Disable builtin file browser
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd[[let g:mapleader = " "]]
-- Lines, numbers, markings
o.relativenumber = true
o.number = true
o.cursorline = true
o.cursorlineopt = "number"

-- Spacing, text, formatting
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true
o.autoindent = true
o.list = true
o.fillchars = "fold: "
vim.wo.foldmethod = "expr"
o.foldlevel = 99
o.foldlevelstart = 1
o.foldnestmax = 2
vim.o.foldtext = [[substitute(getline(v:foldstart),'\\\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

-- Filesystem options
o.swapfile = false
-- o.autochdir = true
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undos"
o.undofile = true
o.undolevels = 500

-- Interactions
o.incsearch = true
o.inccommand = "split"
o.updatetime = 2000
o.timeoutlen = 2000
o.scrolloff = 12
o.jumpoptions = "stack,view" -- jump back to buffer with cursor on same line, in same position
o.virtualedit = "block"

-- Appearance
o.showmode = false
o.numberwidth = 2
o.wrap = false
o.splitright = true
o.splitbelow = true
o.eadirection = "hor" -- equalalwaysdirection is horizontal, so vert splits are preferred
o.guifont = "Jozsef"
o.termguicolors = true
o.cmdheight = 0
vim.diagnostic.config().severity_sort = true
