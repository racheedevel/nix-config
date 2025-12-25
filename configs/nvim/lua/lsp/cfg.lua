local SC = require('manager.shortcuts')
local cache_dir = vim.uv.os_homedir() .. "/.cache/lsp-cache/"

---@type vim.lsp.Config
SC.add_lsp("taplo", {
    cmd = { 'taplo', 'lsp', 'stdio' },
    filetypes = { 'toml' },
    root_markers = { 'Cargo.toml', 'pyproject.toml', '.taplo.toml', 'taplo.toml', '.git' },
})

SC.add_lsp("tombi", {
    cmd = { 'tombi', 'lsp' },
    filetypes = { 'toml' },
    root_markers = { 'Cargo.toml', 'tombi.toml', 'pyproject.toml', '.git' },
})

SC.add_lsp('basedpyright', { ---@type vim.lsp.Client
    cmd = { "basedpyright-langserver", "--stdio" },
    --     -- capabilities = capabilities,
    filetypes = { "python" },
    notify = false,
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
        basedpyright = {
            disableOrganizeImports = true,
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = 'basic',
                inlayHints = {
                    variableTypes = false,
                    callArgumentNames = false,
                    callArgumentNamesMatching = false,
                    functionReturnTypes = false,
                    genericTypes = false,

                }
            },
        },
    },
    commands = {
        PyrightSetPythonPath = {
            function(path)
                local clients = vim.lsp.get_clients({
                    bufnr = vim.api.nvim_get_current_buf(),
                    name = "basedpyright",
                })

                for _, client in ipairs(clients) do
                    if client.settings then
                        client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {},
                            { pythonPath = path })
                    else
                        client.config.settings =
                            vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
                    end
                    client.notify("workspace/didChangeConfiguration", { settings = nil })
                end
            end,
            description = "Reconfigure basedpyright with the provided python path",
            nargs = 1,
            complete = "file",
        },
    },
}, false)

SC.add_lsp('biome', {
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
})

SC.add_lsp('gitlab-ci-ls', {
    cmd = { "gitlab-ci-ls" },
    filetypes = { "yaml.gitlab" },
    -- root_dir = { ".gitlab*", ".git" },
    root_markers = { ".gitlab-ci.yml", ".git" },
    init_options = {
        cache_path = cache_dir,
        log_path = cache_dir .. "/log/gitlab-ci-ls.log",
    },
})

SC.add_lsp('golangci_lint', {
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
})


SC.add_lsp('gopls', {
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
})


SC.add_lsp('hydra-lsp', {
    cmd = { "hydra-lsp" },
    filetypes = { "yaml" },
    root_markers = { ".git" },
    single_file_support = true,
}, false)

SC.add_lsp('json-lsp', {
    cmd = { "vscode-json-language-server", "--stdio" },
    -- 	capabilities = capabilities,
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
    init_options = {
        provideFormatter = true,
    },
})

SC.add_lsp('lua_ls', {
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
})


SC.add_lsp('marksman', {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
})

SC.add_lsp('rubocop', {
    cmd = { "rubocop", "--lsp" },
    filetypes = { "ruby" },
    -- 	capabilities = capabilities,
    root_markers = { "Gemfile", ".git" },
})

SC.add_lsp("pyrefly", {
    cmd = { 'pyrefly', 'lsp' },
    filetypes = { 'python' },
    root_markers = {
        'pyrefly.toml',
        'pyproject.toml',
        '.git',
    },
    on_exit = function(code, _, _)
        vim.notify('Closing Pyrefly LSP exited with code: ' .. code, vim.log.levels.INFO)
    end,
}, true)

SC.add_lsp('ruff', {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    -- 	capabilities = capabilities,
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    -- single_file_support = true,
    settings = {
        organizeImports = true,
        logLevel = "debug",
        codeAction = {
            fixViolation = {
                enable = true,
            }
        }
    },
})

SC.add_lsp('tinymist', require('lsp.tinymist'))

SC.add_lsp('vtsls', {
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
    settings = {
        typescript = {
            preferences = {
                importModuleSpecifier = "non-relative",
            },
        },
    },
})


SC.add_lsp('yaml_ls', {
    cmd = { "yaml-language-server", "--stdio" },
    -- 	capabilities = capabilities,
    filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
    root_markers = { ".git" },
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
    },
})

-- SC.add_lsp("actionlint", {
--     cmd = { "actionlint", "-format", '{{json .}}', '-' },
--     filetypes = { "yaml.github" },
--     root_markers = {
--         '.gitignore',
--         '.git',
--     },
-- })

SC.add_lsp('zls', {
    cmd = { "zls" },
    -- 	capabilities = capabilities,
    filetypes = { "zig", "zir", "zon" },
    root_markers = { "zls.json", "build.zig", ".git" },
    workspace_required = false,
    settings = {
        zls = {
            build_on_save = true,
            semantic_tokens = "partial",
        }
    }
})


SC.add_lsp('zubanls', {
    cmd = { 'zuban', 'server' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        '.git',
    },
}, false)

SC.add_lsp('ty', {
    cmd = { "ty", "server" },
    filetypes = { "python" },
    -- 	capabilities = capabilities,
    root_markers = { "ty.toml", "pyproject.toml", ".git", "requirements.txt", "setup.py", "setup.cfg" },
    settings = {},
}, false)


SC.add_lsp('bash_ls', {
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
})

-- SC.add_lsp('rust-analyzer', {
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
-- })
SC.add_lsp('tailwindcss', {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    -- filetypes copied and adjusted from tailwindcss-intellisense
    filetypes = {
        -- html
        -- 'aspnetcorerazor',
        -- 'astro',
        -- 'astro-markdown',
        -- 'blade',
        'clojure',
        -- 'django-html',
        -- 'htmldjango',
        -- 'edge',
        -- 'eelixir', -- vim ft
        'elixir',
        'ejs',
        'erb',
        -- 'eruby', -- vim ft
        'gohtml',
        'gohtmltmpl',
        'haml',
        'handlebars',
        'hbs',
        'html',
        'htmlangular',
        'html-eex',
        'heex',
        'jade',
        'leaf',
        'liquid',
        'markdown',
        'mdx',
        'mustache',
        'njk',
        'nunjucks',
        -- 'php',
        -- 'razor',
        'slim',
        -- 'twig',
        -- css
        'css',
        -- 'less',
        'postcss',
        -- 'sass',
        -- 'scss',
        'stylus',
        -- 'sugarss',
        -- js
        'javascript',
        'javascriptreact',
        -- 'reason',
        -- 'rescript',
        'typescript',
        'typescriptreact',
        -- mixed
        -- 'vue',
        'svelte',
        'templ',
    },
    settings = {
        tailwindCSS = {
            validate = true,
            lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidScreen = 'error',
                invalidVariant = 'error',
                invalidConfigPath = 'error',
                invalidTailwindDirective = 'error',
                recommendedVariantOrder = 'warning',
            },
            classAttributes = {
                'class',
                'className',
                'class:list',
                'classList',
                'ngClass',
            },
            includeLanguages = {
                -- eelixir = 'html-eex',
                -- elixir = 'phoenix-heex',
                -- eruby = 'erb',
                -- heex = 'phoenix-heex',
                htmlangular = 'html',
                templ = 'html',
            },
        },
    },
    before_init = function(_, config)
        if not config.settings then
            config.settings = {}
        end
        if not config.settings.editor then
            config.settings.editor = {}
        end
        if not config.settings.editor.tabSize then
            config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
        end
    end,
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
        local root_files = {
            -- Generic
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.mjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.cjs',
            'postcss.config.mjs',
            'postcss.config.ts',
            -- Django
            'theme/static_src/tailwind.config.js',
            'theme/static_src/tailwind.config.cjs',
            'theme/static_src/tailwind.config.mjs',
            'theme/static_src/tailwind.config.ts',
            'theme/static_src/postcss.config.js',
            -- Fallback for tailwind v4, where tailwind.config.* is not required anymore
            '.git',
            'package.json'
        }
        local fname = vim.api.nvim_buf_get_name(bufnr)
        -- root_files = util.insert_package_json(root_files, 'tailwindcss', fname)
        -- root_files = util.root_markers_with_field(root_files, { 'mix.lock', 'Gemfile.lock' }, 'tailwind', fname)
        on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
    end,
})
