vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim", "https://github.com/polirritmico/telescope-lazy-plugins.nvim",
    "https://github.com/BurntSushi/ripgrep", "https://github.com/MunifTanjim/nui.nvim" })
vim.pack.add({ { src = "https://github.com/nvim-telescope/telescope.nvim" } })
local telescope = require("telescope")

local builtin = require("telescope.builtin")
function map(mode, map, cmd, description)
    -- Sets a key mapping for the given mode (e.g., 'n' for normal, 'i' for insert),
    -- binding the key sequence `map` to execute the command `cmd`.
    -- Includes a description for the mapping, using either the provided description or the command itself.
    vim.keymap.set(mode, map, cmd, { desc = description or cmd })
end

telescope.load_extension("lazy_plugins")




telescope.setup({
    defaults = {
        file_ignore_patterns = { ".git/" },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob",
            "!.git/*",
        },
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = { width = 0.9, preview_width = 0.5 },
        },
        prompt_prefix = " ",
        selection_caret = "➜ ",
        path_display = { "truncate" },
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
    },
    extensions = {
        lazy_plugins = {
            lazy_config = vim.fn.stdpath("config") .. "/init.lua",
        },
    },
})

map("n", "<leader><leader>", builtin.live_grep, "Live Grep")
map("n", "<leader>b", builtin.buffers, "Buffers")
map("n", "<leader>ss", builtin.current_buffer_fuzzy_find, "Find in file")
map("n", "<leader>sf", builtin.find_files, "Find files")
map("n", "<leader>sg", builtin.git_files, "Git files")

map("n", "<leader>sx", "<cmd>Telescope diagnostics bufnr=0<CR>", "Diagnostics")
map("n", "<leader>sX", builtin.diagnostics, "All buffer diagnostics")
map("n", "<leader>si", builtin.lsp_implementations, "Implementation")
map("n", "<leader>sd", builtin.lsp_definitions, "Definition")
map("n", "<leader>sD", builtin.lsp_type_definitions, "Type definition")

map("n", "<leader>sh", builtin.help_tags, "Help tags")
map("n", "<leader>sH", builtin.highlights, "Highlights")
map("n", "<leader>uC", builtin.colorscheme, "Colorschemes")
map("n", "<leader>sc", builtin.command_history, "Command history")
map("n", "<leader>sS", builtin.search_history, "Search History")
map("n", "<leader>sm", builtin.man_pages, "Man pages")
map("n", "<leader>sq", builtin.quickfix, "Quickfix")
map("n", "<leader>sk", builtin.keymaps, "Keymaps")
map("n", "<leader>sp", "<cmd>Telescope lazy_plugins<CR>", "Plugin Specs")
map("n", "<leader>sr", builtin.reloader, "Reloader")
map("n", "<leader>sP", builtin.builtin, "Pickers")
