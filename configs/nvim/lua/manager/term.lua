local T = {}

function T.root_cwd()
    return vim.fn.getcwd()
end

---@param pct number
function T.area_size_pct(pct)
    return { pct = pct }
end


local function default_shell()
    local sh = vim.o.shell or "sh"
    return sh
end
---@param area "right"|"bottom"
---@param size number|table<{pct: number}>
local function open_area(area, size)
    local where = (area == "right") and "botright vsplit" or "botright split"
    vim.cmd(where)

    if type(size) == "table" and size.pct then
        if area == 'right' then
            local cols = vim.o.columns
            vim.cmd(("vertical resize %d"):format(math.max(10, math.floor(cols * size.pct / 100))))

        else
            local lines = vim.o.lines - vim.o.cmdheight
            vim.cmd(("resize %d"):format(math.max(5, math.floor(lines * size.pct / 100))))
        end

    elseif type(size) == "number" then
        if area == 'right' then
            vim.cmd(("vertical resize %d"):format(size))
        else
            vim.cmd(("resize %d"):format(size))
        end
    end
end

---@class TrmOpts
--- @field cmd string|table
--- @field cwd string
--- @field env table
--- @field insert boolean
--- @field area "right"|"bottom"
--- @field persist boolean
--- @field on_exit fun(code, signal)

---@param opts TrmOpts
function T.start_term(opts)
    opts = opts or {}
    local cmd = opts.cmd or default_shell()

    if vim.bo.buftype ~= "" then
        vim.cmd("enew")
    end

    local jid = vim.fn.jobstart(cmd, {
        cwd = opts.cwd,
        env = opts.env,
        term = true,
        on_exit = function(job_id, code, signal)
            if type(opts.on_exit) == 'function' then
                pcall(opts.on_exit, code, signal)
            end
            if opts.persist == false then
                vim.schedule(function()
                    local win = vim.fn.bufwinnr(vim.api.nvim_get_current_buf())
                    if win ~= -1 then
                        pcall (vim.cmd, (win .."wincmd c"))
                    end
                end)
            end
        end,
    })
    if jid <= 0 then
        vim.notify("Failed to start terminal/job", vim.log.levels.ERROR)
        return nil
    end

    vim.b.terminal_job_id = jid
    vim.b.term_area = opts.area or vim.b.term_area or "bottom"
    vim.bo.bufhidden = "hide"
    vim.wo.number, vim.wo.relativenumber, vim.wo.signcolumn, vim.wo.cursorline = false, false, "no", false

    if opts.insert ~= false then
        vim.cmd("startinsert")
    end

    return { bufnr = vim.api.nvim_get_current_buf(), job_id = jid }
end

---@param opts table : TrmOpts, {size: number}
function T.open_in_area(opts)
    local opt = opts or {}
    local area = opt.area or "right"
    open_area(area, opt.size or { pct = 20 })
    return T.start_term(vim.tbl_extend("force", opt, { area = area }))
end

function T.split_in_term_area(opts)
    opts = opts or {}
    if vim.bo.buftype ~= "terminal" then
        vim.notify("Not in a terminal window", vim.log.levels.WARN)
        return
    end

    local area = vim.b.term_area or "bottom"
    if area == "bottom" then
        vim.cmd("vsplit")
    else
        vim.cmd("split")
    end
    return T.start_term(vim.tbl_extend("force", { area = area }, opts))
end

function T.send_current(cmdline)
    local job = vim.b.terminal_job_id
    if not job then
        vim.notify("No terminal job in this buffer", vim.log.levels.WARN)
        return
    end
    vim.api.nvim_chan_send(job, cmdline .. "\n")
end

return T
