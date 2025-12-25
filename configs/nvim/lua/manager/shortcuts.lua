local U = require('manager.utils')
local P = {}

---A small abstraction for keymap
---@param mode string|string[]
---@param map string
---@param cmd string|fun()
---@param description? string
function P.map(mode, map, cmd, description)
    -- Sets a key mapping for the given mode (e.g., 'n' for normal, 'i' for insert),
    -- binding the key sequence `map` to execute the command `cmd`.
    -- Includes a description for the mapping, using either the provided description or the command itself.
    vim.keymap.set(mode, map, cmd, { desc = description or (type(cmd) == 'string') and cmd or "" })
end

---Add an lsp to VIM
---@param name string
---@param config vim.lsp.Config
---@param enabled? boolean
function P.add_lsp(name, config, enabled)
    if type(config) == 'table' then
        vim.lsp.config[name] = config
    else
        vim.notify("[utils.add_lsp] LSP config is not a table", vim.log.levels.ERROR)
    end
    if enabled ~= false then vim.lsp.enable(name) end
end

---@class PluginSpecs
--- @field [1]? string
--- @field src? string
--- @field alias string
--- @field version string
--- @field no_setup? boolean
--- @field opts table
--- @field ev string|string[]
--- @field ft string|string[]

---Add plugin
---@param spec string|PluginSpecs
function P.add_plugin(spec)
    local src
    if type(spec) == 'string' then src = spec end
    if type(spec[1]) == "string" then src = spec[1] end
    if type(spec.src) == 'string' then src = spec.src end

    local version
    if type(spec.version) == 'string' then version = U.normalize_version(spec.version) end

    local alias
    if type(spec.alias) == 'string' and spec.alias ~= nil then alias = spec.alias end

    local opts
    if type(spec.opts) == 'table' then opts = spec.opts end

    local ev
    if type(spec.ev) == 'string' and spec.ev ~= "" then
        ev = { spec.ev }
    elseif type(spec.ev) == 'table' and type(spec.ev[1]) == 'string' and spec.ev[1] ~= nil then
        ev = spec.ev
    end

    local ft
    if type(spec.ft) == 'string' and spec.ft ~= "" then
        ft = { spec.ft }
    elseif type(spec.ft) == 'table' and type(spec.ft[1]) == 'string' and spec.ft[1] ~= nil then
        ft = spec.ft
    end
    if src == nil then error("[manager] plugin source could not be parsed") end
    local source, name = U.parse_src_str(src)
    local packspec = {
        src = source
    }
    if version ~= nil then packspec.version = version end
    if alias ~= nil and alias ~= name then packspec.name = alias end

    local ok, retv = pcall(vim.pack.add, { packspec })
    if not ok then
        error(("[manager] error initializing plugin %s: %s"):format(name, retv))
    end
    if spec.no_setup == true then return end
    if ev ~= nil or ft ~= nil then
        local aug = vim.api.nvim_create_augroup("protoplugs", {})
        local final_name = alias or name
        ---@type vim.api.keyset.create_autocmd
        local aspec = {
            desc = ("[manager_autocmd] initialize %s"):format(final_name),
            group = aug
        }
        if ft ~= nil then aspec.pattern = ft end
        aspec.callback = function()
            local ok2, plugin = pcall(require, final_name)
            if not ok2 then error(("[manager] plugin %s (%s) not resolved on rtp: %s"):format(final_name, source, plugin)) end
            local ok3, err = pcall(plugin.setup, opts or {})
            if not ok3 then
                error(("[manager] plugin %s (%s) could not be initialized by setup function. if it doesn't exist, please include `no_setup = true` in definition. error: %s")
                    :format(final_name, source, plugin))
            end
        end
        vim.api.nvim_create_autocmd(ev or "FileType", aspec)
    end
end

return P
