



local cache_dir = vim.uv.os_homedir() .. "/.cache/lsp-cache/"
-- LuaLS library requirement



vim.lsp.config['basedpyright'] = {
    cmd = { "basedpyright-langserver", "--stdio" },
    --     -- capabilities = capabilities,
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
            },
        },
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
            local params = {
                command = 'basedpyright.organizeimports',
                arguments = { vim.uri_from_bufnr(bufnr) },
            }

            -- Using client.request() directly because "basedpyright.organizeimports" is private
            -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
            -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
            client.request('workspace/executeCommand', params, nil, bufnr)
        end, {
            desc = 'Organize Imports',
        })

        -- vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
        --     desc = 'Reconfigure basedpyright with the provided python path',
        --     nargs = 1,
        --     complete = 'file',
        -- })
    end,
}

vim.lsp.config['biome'] = {
    cmd = { "biome", "lsp-proxy" },
    --     capabilities = capabilities,
    filetypes = {
        "astro",
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "svelte",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "vue",
    },
    root_markers = { "package.json", "tsconfig.json", ".git", "node_modules" },
    settings = {},
}

vim.lsp.config['gitlab-ci-ls'] = {
    cmd = { "gitlab-ci-ls" },
    filetypes = { "yaml.gitlab" },
    -- root_dir = { ".gitlab*", ".git" },
    root_markers = { ".gitlab-ci.yml", ".git" },
    init_options = {
        cache_path = cache_dir,
        log_path = cache_dir .. "/log/gitlab-ci-ls.log",
    },
}


vim.lsp.config['golangci_lint'] = {
    cmd = { "golangci-lint-langserver" },
    -- 	capabilities = capabilities,
    filetypes = { "go", "gomod" },
    init_options = {
        command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
    },
    root_markers = {
        ".golangci.yml",
        ".golangci.yaml",
        ".golangci.toml",
        ".golangci.json",
        "go.work",
        "go.mod",
        ".git",
    },
}


vim.lsp.config['gopls'] = {
    cmd = { "gopls" },
    -- 	capabilities = capabilities,
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            usePlaceholders = true,
            staticcheck = true,
            codelenses = {
                test = true,
            },
        },
    },
}


vim.lsp.config['hydra-lsp'] = {
    cmd = { "hydra-lsp" },
    filetypes = { "yaml" },
    root_dir = { ".git" },
    single_file_support = true,
}


vim.lsp.config['json-lsp'] = {
    cmd = { "vscode-json-language-server", "--stdio" },
    -- 	capabilities = capabilities,
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
    init_options = {
        provideFormatter = true,
    },
}


vim.lsp.config['lua_ls'] = {
    cmd = { "lua-language-server" },
    -- 	capabilities = capabilities,
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
                pathStrict = false,
            },
            workspace = {
                checkThirdParty = false,
                library = (function()
                    local library = vim.api.nvim_get_runtime_file("", true)
                    -- table.insert(library, "${3rd}/luv/library")
                    -- table.insert(library, vim.env.HOME .. "/x/personal/lua/sup/lua")
                    -- table.insert(library, vim.env.HOME .. "/x/personal/lua/sup")
                    table.insert(library, "/x/r/lua/proto/")
                    table.insert(library, "/x/r/lua/proto/lua")
                    return library
                end)(),
            },
            diagnostics = {
                globals = { 'vim' },
                disable = { "missing-fields" },
            },
            hint = { enable = true },
        },
    },
}


vim.lsp.config['marksman'] = {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
}


vim.lsp.config['rubocop'] = {
    cmd = { "rubocop", "--lsp" },
    filetypes = { "ruby" },
    -- 	capabilities = capabilities,
    root_markers = { "Gemfile", ".git" },
}


vim.lsp.config['ruff'] = {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    -- 	capabilities = capabilities,
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    -- single_file_support = true,
    settings = {},
}


vim.lsp.config['tinymist'] = require('lsp.tinymist')

vim.lsp.config['vtsls'] = {
    cmd = { "vtsls", "--stdio" },
    -- 	capabilities = capabilities,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_markers = { "tsconfig.json", "package.json", "jsconfig.json" },
}


vim.lsp.config['yaml-language-server'] = {
    cmd = { "yaml-language-server", "--stdio" },
    -- 	capabilities = capabilities,
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
    },
}


vim.lsp.config['zls'] = {
    cmd = { "zls" },
    -- 	capabilities = capabilities,
    filetypes = { "zig", "zir" },
    root_markers = { "zls.json", "build.zig", ".git" },
    workspace_required = false,
}

-- vim.lsp.config['zubanls'] = {
--     cmd = { 'zuban', 'server' },
--     filetypes = { 'python' },
--     root_markers = {
--         'pyproject.toml',
--         'setup.py',
--         'setup.cfg',
--         'requirements.txt',
--         'Pipfile',
--         '.git',
--     },
-- }


-- vim.lsp.config['ty'] = {
--     cmd = { "ty", "server" },
--     filetypes = { "python" },
--     -- 	capabilities = capabilities,
--     root_markers = { "ty.toml", "pyproject.toml", ".git", "requirements.txt", "setup.py", "setup.cfg" },
--     settings = {},
-- }

vim.lsp.config["bash-language-server"] = {
    cmd = { 'bash-language-server', 'start' },
    settings = {
        bashIde = {
            -- Glob pattern for finding and parsing shell script files in the workspace.
            -- Used by the background analysis features across files.

            -- Prevent recursive scanning which will cause issues when opening a file
            -- directly in the home directory (e.g. ~/foo.sh).
            --
            -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
            globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
        },
    },
    filetypes = { 'bash', 'sh' },
    root_markers = { '.git' },
}

-- vim.lsp.config['rust-analyzer'] = {
-- 	cmd = { "rust-analyzer" },
-- -- 	capabilities = capabilities,
-- 	filetypes = { "rust" },
-- 	root_markers = { "Cargo.toml", ".git" },
-- 	settings = {
-- 		["rust-analyzer"] = {
-- 			check = { command = "clippy" },
-- 			cargo = { features = "all" },
-- 		},
-- 	},
-- }
