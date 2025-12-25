vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ { src = "https://github.com/nvim-tree/nvim-tree.lua" } })
local function attach_fn(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "Files: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    --         api.events.subscribe(api.events.Event.TreeOpen, function() -- Custom statusline for NvimTree
    --           local tree_winid = api.tree.winid()

    --           if tree_winid ~= nil then
    --             vim.api.nvim_set_option_value('statusline', '%t', { win = tree_winid })
    --           end
    --         end)

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "<leader>v", api.node.open.vertical, opts("Open vertical"))
    vim.keymap.set("n", "<leader>h", api.node.open.horizontal, opts("Open horizontal"))
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

-- pass to setup along with your other options
require("nvim-tree").setup({
    sort = {
        sorter = "name",
        folders_first = false,
    },
    on_attach = attach_fn,
    hijack_unnamed_buffer_when_opening = true,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    view = {
        width = 45,
        side = "left",
        centralize_selection = true,
    },
    git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
        cygwin_support = false,
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 500,
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        },
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        enable = true,
        git_ignored = false,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        no_bookmark = false,
        custom = {
            "__pycache__",
            "^\\.git$",
            "^\\.venv",
        },
        exclude = {},
    },
    update_focused_file = {
        enable = true,
        update_root = {
            enable = false,
            ignore_list = {},
        },
        exclude = false,
    },
    renderer = {
        add_trailing = false,
        full_name = false,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        special_files = {
            "Cargo.toml",
            "Dockerfile",
            "docker-compose.yml",
            "package.json",
            "main.go",
            "main.rs",
            "main.py",
            "Makefile",
            "README.md",
            "readme.md",
        },
        hidden_display = "none",
        symlink_destination = true,
        decorators = { "Git", "Open", "Hidden", "Modified", "Bookmark", "Diagnostics", "Copied", "Cut" },
        highlight_git = "icon",
        highlight_diagnostics = "none",
        highlight_opened_files = "all",
        highlight_modified = "icon",
        highlight_hidden = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "name",
        group_empty = false,
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            web_devicons = {
                file = {
                    enable = true,
                    color = true,
                },
                folder = {
                    enable = false,
                    color = true,
                },
            },
            git_placement = "signcolumn",
            modified_placement = "right_align",
            hidden_placement = "right_align",
            diagnostics_placement = "signcolumn",
            bookmarks_placement = "signcolumn",
            padding = {
                icon = " ",
                folder_arrow = " ",
            },
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = true,
                hidden = true,
                diagnostics = true,
                bookmarks = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                bookmark = "󰍎",
                modified = "󰦒",
                hidden = "󰈉",
                folder = {
                    arrow_closed = "󰍟",
                    arrow_open = "󰍝",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "󰄲",
                    unmerged = "",
                    renamed = "",
                    untracked = "",
                    deleted = "󰆴",
                    ignored = "󱋮",
                },
            },
        },
    },
    system_open = {
        cmd = "dragon",
        args = {},
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        expand_all = {
            max_folder_discovery = 300,
            exclude = {},
        },
        file_popup = {
            open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
        },
        open_file = {
            quit_on_open = true,
            eject = true,
            resize_window = true,
            relative_path = true,
            window_picker = {
                enable = true,
                picker = "default",
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
        remove_file = {
            close_window = true,
        },
    },
    ui = {
        confirm = {
            remove = true,
            trash = false,
            default_yes = true,
        },
    },
})
