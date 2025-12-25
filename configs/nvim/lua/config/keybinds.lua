local map = function(mode, map, cmd, description)
    -- Sets a key mapping for the given mode (e.g., 'n' for normal, 'i' for insert),
    -- binding the key sequence `map` to execute the command `cmd`.
    -- Includes a description for the mapping, using either the provided description or the command itself.
    vim.keymap.set(mode, map, cmd, { desc = description or cmd })
end

-- Tabs
map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>", "Tab 1")
map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>", "Tab 2")
map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>", "Tab 3")
map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>", "Tab 4")
map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>", "Tab 5")
map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>", "Tab 6")
map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>", "Tab 7")
map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>", "Tab 8")
map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>", "Tab 9")
map("n", "<A-0>", "<cmd>BufferLineGoToBuffer 10<CR>", "Tab 10")
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", "Next tab")
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", "Previous tab")
map("n", "<A-Right>", "<cmd>BufferLineMoveNext<CR>", "Move tab forward")
map("n", "<A-Left>", "<cmd>BufferLineMovePrev<CR>", "Move tab backwards")
map("n", "<C-Esc>", "<cmd>bd<CR>", "Close tab")
map("n", "<Leader>q", "<cmd>bd<CR>", "Close tab")
map("n", "<leader>S", "<cmd>w<CR>", "Save buffer")

-- Window
map("n", "<leader>Q", "<cmd>q<CR>", "Quit")
map("n", "<leader-C>q", "<cmd>q!<CR>", "Force quit")
-- map({ "n", "t" }, "<C-\\>", "<cmd>FloatermToggle<CR>", "Terminal")

-- Disable highlights on "ESC"
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Remove highlights")

-- # Delete remaps
map("v", "d", '"_d', "Delete")
map("v", "D", '"_D', "Delete to end of line")
map("n", "dd", '"_dd', "Delete line")

-- # Visual mappings

-- # buffer modification mappings
map("n", "<End>", "o<Esc>", "New line below")
map("n", "<Home>", "O<Esc>", "New line above")
map("n", "p", '"+p', "Paste")
map("n", "P", '"+P', "Paste")
map("v", "p", '"+P', "Paste")
map("v", "P", '"+p', "Paste")
map("v", "x", '"+x')
map("v", "y", '"+y', "Copy")
map("i", "<A-BS>", "<C-w>")
map("n", "<C-j>", "<C-w><Down>", "Move one window down")
map("n", "<C-k>", "<C-w><Up>", "Move one window up")
map("n", "<C-h>", "<C-w><Left>", "Move one window left")
map("n", "<C-l>", "<C-w><Right>", "Move one window right")

-- Editing
-- Diagnostics
map("n", "<leader>uv", function()
    local new_config = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = new_config })
end, "Toggle diagnostic virtual_text")



-- Word-by-word
map({ "i", "x" }, "<A-Left>", "<C-o>b", "Move word backwards")
map({ "i", "x" }, "<A-Right>", "<C-o>W", "Move word forward")
map({ "n", "v" }, "<A-Left>", "b", "Move word backwards")
map({ "n", "v" }, "<A-Right>", "e", "Move word forward")

-- Plugin keymaps
--
-- LazyGit
-- map("n", "<leader>g", "<cmd>LazyGit<CR>", "LazyGit")

-- AI
--
map("v", "<A-c>", "<cmd>AIRewrite Comment<CR>", "Comment above")
map("v", "<A-r>", "<cmd>AIRewrite<CR>", "Rewrite with AI")
map("v", "<A-p>", "<cmd>AIAppend<CR>", "Append with AI")
map("v", "<A-i>", "<cmd>AIImplement<CR>", "Implement selected text")
map({ "v", "i", "x", "n" }, "<A-a>f", "<cmd>AIChatToggle popup<CR>", "New floating chat")
map({ "v", "i", "x", "n" }, "<A-a>v", "<cmd>AIChatToggle vsplit<CR>", "New split chat")
map({ "v", "n" }, "<Leader>An", "<cmd>AIChatNew<CR>", "New AI Chat")
map({ "v", "n" }, "<Leader>At", "<cmd>AIChatToggle<CR>", "Toggle chat")
map("v", "<Leader>Ap", "<cmd>AIChatPaste<CR>", "Paste selection")
map({ "v", "n" }, "<Leader>Ad", "<cmd>AIChatDelete<CR>", "Delete chat")
map({ "v", "n" }, "<Leader>Ar", "<cmd>AIChatRespond<CR>", "Trigger response")
map({ "v", "n" }, "<Leader>A<Leader>", "<cmd>AIChatStop<CR>", "Stop responding")
map({ "v", "n" }, "<Leader>AM", "<cmd>AIModel<CR>", "Choose model")
map({ "v", "n" }, "<Leader>AP", "<cmd>AIProvider<CR>", "Choose provider")
map({ "v", "n" }, "<Leader>AT", "<cmd>AIThinking<CR>", "Configure Thinking")
map({ "v", "n" }, "<Leader>AS", "<cmd>AIStatus<CR>", "Status")
map({ "v", "n" }, "<Leader>A/", "<cmd>AIChatFinder<CR>", "Find chat")
-- -- -- Treesitter context
map("n", "<leader>uc", "<cmd>TSContextToggle<CR>", "Toggle tree-sitter context")
-- -- -- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeOpen<CR>", "Tree - Toggle")
map("n", "<leader>T", "<cmd>NvimTreeToggle<CR>", "Tree - Toggle")

-- General
map({ "n", "v" }, ";", ":", "Command")
map({ "n", "v" }, "<leader>.", ":<C-p><CR>", "Command")

map("n", "<leader>us", function()
    vim.opt.scrolloff = 999 - vim.o.scrolloff
end, "Scroll with cursor in middle")


map("n", "<leader>ub", "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle git blames")
map("n", "<localleader>w", "ciw", "Replace word")
map("n", "<localleader>W", "caw", "Replace around word")
map("n", "<localleader>,", "ct,", "Replace until ','")
map("n", "<localleader>{", "ci{", "Replace within {}")
map("n", "<localleader>(", "ci(", "Replace within ()")
map("n", "<localleader>[", "ci[", "Replace within []")

