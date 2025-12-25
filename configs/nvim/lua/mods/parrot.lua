vim.pack.add({ "https://github.com/ibhagwan/fzf-lua", "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ { src = "https://github.com/frankroeder/parrot.nvim", version = vim.version.range("1.8") } })
local open = io.open
local function read_file(path)
    local file = open(path, "rb") -- r read mode and b binary mode
    if not file then
        return nil
    end
    local content = file:read("*a") -- *a or *all reads the whole file
    file:close()
    return content
end
require("parrot").setup({
    providers = {
        groq = {
            name = "groq",
            api_key = os.getenv "GROQ_API_TOKEN",
            model_endpoint = "https://api.groq.com/openai/v1/models",
            endpoint = "https://api.groq.com/openai/v1/chat/completions",
            model = {
                "llama-3.3-70b-versatile",
            },
        },
        mistral = {
            name = "mistral",
            api_key = os.getenv "MISTRAL_API_TOKEN",
            endpoint = "https://api.mistral.ai/v1/chat/completions",
            models = {
                "mistral-small-latest",
                "open-codestral-mamba",
            },
        },
        custom = { -- codestral
            name = "codestral",
            style = "openai",
            api_key =  os.getenv "CODESTRAL_API_TOKEN",
            endpoint = "https://codestral.mistral.ai/v1/chat/completions",
            models = {
                "codestral-latest",
            },
        },
        anthropic = {
            name = "anthropic",
            api_key = os.getenv "CLAUDE_API_TOKEN",
            endpoint = "https://api.anthropic.com/v1/messages",
            model_endpoint = "https://api.anthropic.com/v1/models",
            models = {
                "claude-sonnet-4-0",
                "claude-3-7-sonnet-latest",
            },
        },
    },

    cmd_prefix = "AI",

    -- The directory to store persisted state information like the
    -- current provider and the selected models
    state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/parrot/persisted",

    -- The directory to store the chats (searched with PrtChatFinder)
    chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/parrot/chats",

    -- Chat user prompt prefix
    chat_user_prefix = "🗨:",

    -- llm prompt prefix
    llm_prefix = "🦜:",

    online_model_selection = false,
    -- Local chat buffer shortcuts
    chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<A-a><A-a>" },
    chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<A-a>d" },
    chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<A-a>s" },
    chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<A-a>n" },

    toggle_target = "popup",

    user_input_ui = "native",

    enable_spinner = true,

    spinner_type = "bouncing_ball",

    show_context_hints = true,

    show_thinking_window = true,

    command_auto_select_response = true,

    prompts = {
        ["Comment"] = "Provide a comment that explains what the snippet is doing.", -- e.g., :'<,'>PrtPrepend Comment
        --         ["Complete"] = "Continue the implementation of the provided snippet in the file {{filename}}." -- e.g., :'<,'>PrtAppend Complete
    },
})
