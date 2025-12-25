local P = {}

local S = {}

---Trims whitespace from start and end of string
---@param s string
---@return string
local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

---Returns true if `s` contains no `/` character and is composed of only a word,
---possibly including `_`, `-`, `.` characters.
---@param s string
---@return boolean
local function is_single_token(s)
    return s and s:match("^[%w._-]+$") ~= nil and not s:find("/")
end

---Parses a github URL into a `user` and a `repo` or returns `nil` if no URL was found.
---@param s string
---@return string|nil
---@return string|nil
local function parse_github_url(s)
    local user, repo = s:match("^https?://github%.com/([^/%s]+)/([^/%s]+)")
    if user and repo then return user, repo:gsub("%.git$", "") end
end


---Parses a github URL into a `user` and a `repo` or returns `nil` if no URL was found.
---@param s string
---@return string|nil
---@return string|nil
local function parse_repo_url(s)
    local user, repo = s:match("^https?://[%w_-.]%.com/([^/%s]+)/([^/%s]+)")
    if user and repo then return user, repo:gsub("%.git$", "") end
end

---Parses a source expression from `user/repo` to user and repo
---@param s string
---@return string|nil
---@return string|nil
local function parse_user_repo(s)
    if not s or s:find("%s") then return nil end
    local u, r = s:match("^([^/%s]+)/([^/%s]+)$")
    if u and r then return u, r end
end

---Parse a plugin *URL*-ish source into: normalized_url, repo, owner
---returns nil,nil,nil if `src` doesn't look like a URL
---@param src string
---@return string|nil url
---@return string|nil repo
---@return string|nil owner
local function parse_plugin_url(src)
  if type(src) ~= "string" then return nil, nil, nil end
  local s = src:gsub("^%s+", ""):gsub("%s+$", "")

  -- normalize common noise
  s = s:gsub("/+$", "")  -- drop trailing slashes

  -- helpers
  local function strip_dot_git(name)
    return (name:gsub("%.git$", ""))
  end
  local function split_path(p)
    local t = {}
    for seg in p:gmatch("[^/]+") do
      if #seg > 0 then table.insert(t, seg) end
    end
    return t
  end
  local function norm_host(h)
    return (h:gsub("^www%.", "")) -- strip leading www.
  end

  -- 1) SCP-style: git@host:user/repo(.git)
  do
    local user_at, host, path = s:match("^([%w%._-]+)@([%w%.-]+):(.+)$")
    if user_at and host and path then
      path = path:gsub("/+$", "")
      local parts = split_path(path)
      if #parts >= 2 then
        local repo = strip_dot_git(parts[#parts])
        local owner = table.concat(parts, "/", 1, #parts - 1)
        local url = string.format("ssh://%s@%s/%s/%s", user_at, norm_host(host), owner, repo)
        return url, owner, repo
      end
      return nil, nil, nil
    end
  end

  -- 2) ssh://user@host/user/repo(.git)
  do
    local scheme, user_at, host, path = s:match("^(ssh)://([^@]+)@([^/]+)/(.+)$")
    if scheme and user_at and host and path then
      path = path:gsub("/+$", "")
      local parts = split_path(path)
      if #parts >= 2 then
        local repo = strip_dot_git(parts[#parts])
        local owner = table.concat(parts, "/", 1, #parts - 1)
        local url = string.format("ssh://%s@%s/%s/%s", user_at, norm_host(host), owner, repo)
        return url, owner, repo
      end
      return nil, nil, nil
    end
  end

  -- 3) http(s)/git://host/user/repo(.git)[/...]
  do
    local scheme, host, path = s:match("^(https?)://([^/]+)/(.+)$")
    if not scheme then scheme, host, path = s:match("^(git)://([^/]+)/(.+)$") end
    if scheme and host and path then
      -- trim to repo-root-ish: drop trailing segments after owner/repo if user pasted a deep URL
      path = path:gsub("/+$", "")
      local parts = split_path(path)
      -- heuristic:
      --   for GitHub-like: owner/repo are the first 2 segments
      --   for GitLab-like *clone* URLs, path is already <namespace...>/<repo>.git; we take last segment as repo.
      -- try to detect clone-ish path: has .git on last segment OR looks like exactly owner/repo
      if #parts >= 2 then
        local last = parts[#parts]
        local repo = strip_dot_git(last)
        local owner = table.concat(parts, "/", 1, #parts - 1)
        -- rebuild normalized URL (keep original scheme; strip .git; strip www.)
        local url = string.format("%s://%s/%s/%s", scheme, norm_host(host), owner, repo)
        return url, owner, repo
      end
      return nil, nil, nil
    end
  end

  -- 4) bare host path: host/user/repo(.git)
  do
    local host, path = s:match("^([^/%s]+%.[^/%s]+)/(.+)$")
    if host and path then
      path = path:gsub("/+$", "")
      local parts = split_path(path)
      if #parts >= 2 then
        local repo = strip_dot_git(parts[#parts])
        local owner = table.concat(parts, "/", 1, #parts - 1)
        local url = string.format("https://%s/%s/%s", norm_host(host), owner, repo)
        return url, owner, repo
      end
      return nil, nil, nil
    end
  end

  return nil, nil, nil
end


-- # Plugin version parsing

---Asserts that `s` is semver (v0.0.0)
---@param s any
---@return boolean
local function is_semver(s) return s:match("^v?%d+%.%d+%.%d+") ~= nil end

---Asserts that `s` is a semver range (^1, <=1, >=1, ==1, 1.*)
---@param s string
---@return boolean
local function is_semver_range(s) return s:match("[%^~><=*]") ~= nil end

---Normalizes plugin version either by trimming or calling vim.version.range on it
---@param ver string
---@return string|vim.VersionRange?
local function normalize_version(ver)
    if type(ver) ~= string then return ver end

    local v = trim(ver)

    if is_semver(v) or is_semver_range(v) then
        local ok, range = pcall(vim.version.range, v)
        if ok then return range end
    end
    return v
end

---Parses plugin source and alias from table key and source string
---@param s string
---@return string|nil src
---@return string|nil id
local function parse_src_str(s)
    local url, owner, repo = parse_plugin_url(s)
    if url ~= nil and owner ~= nil and repo ~= nil then
        return url, repo
    end

    owner, repo = parse_user_repo(s)
    if owner ~= nil and repo ~= nil then
        return "https://github.com/" .. owner .. "/" .. repo, repo
    end

    return nil, nil
end


---Add plugin
---@param spec string|PluginSpecs
function P.add_plugin(spec)
    local src
    if type(spec) == 'string' then src = spec end
    if type(spec[1]) == "string" then src = spec[1] end
    if type(spec.src) == 'string' then src = spec.src end

    local version
    if type(spec.version) == 'string' then version = normalize_version(spec.version) end

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
    local source, name = parse_src_str(src)
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
