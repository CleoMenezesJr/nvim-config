vim.pack.add(
  { { src = "https://github.com/folke/snacks.nvim", version = vim.version.range("2.*.*") } },
  { load = true, confirm = false }
)

local picker = require("snacks").picker;
require('snacks').setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = { enabled = false },
  indent = { enabled = false },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = false },
  dim = { enabled = false },
  gh = { enabled = false },
  image = { enabled = false },
  layout = { enabled = false },
  lazygit = { enabled = false },
  profiler = { enabled = false },
  rename = { enabled = false },
  scratch = { enabled = false },
  toggle = { enabled = false },
  styles = {
    notification = {
      wo = { wrap = true } -- Wrap notifications
    }
  }
})

-- Top Pickers & Explorer
vim.keymap.set("n", "<leader><space>", function() picker.smart() end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>,", function() picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", function() picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>:", function() picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>n", function() picker.notifications() end, { desc = "Notification History" })
-- vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "File Explorer" })

-- find
-- vim.keymap.set("n", "<leader>fb", function() picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function() picker.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", function() picker.files() end, { desc = "Find Files" })
-- vim.keymap.set("n", "<leader>fg", function() picker.git_files() end, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fp", function() picker.projects() end, { desc = "Projects" })
vim.keymap.set("n", "<leader>fr", function() picker.recent() end, { desc = "Recent" })

-- git
vim.keymap.set("n", "<leader>gb", function() picker.git_branches() end, { desc = "Git Branches" })
vim.keymap.set("n", "<leader>gl", function() picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gL", function() picker.git_log_line() end, { desc = "Git Log Line" })
vim.keymap.set("n", "<leader>gs", function() picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function() picker.git_stash() end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gd", function() picker.git_diff() end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gf", function() picker.git_log_file() end, { desc = "Git Log File" })

-- Grep
vim.keymap.set("n", "<leader>sb", function() picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", function() picker.grep_buffers() end, { desc = "Grep Open Buffers" })
vim.keymap.set("n", "<leader>sg", function() picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>sw", function() picker.grep_word() end, { desc = "Visual selection or word" })

-- search
vim.keymap.set("n", "<leader>sc", function() picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", function() picker.commands() end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", function() picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function() picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
-- vim.keymap.set("n", "<leader>sh", function() picker.help() end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", function() picker.highlights() end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>si", function() picker.icons() end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", function() picker.jumps() end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function() picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function() picker.loclist() end, { desc = "Location List" })
vim.keymap.set("n", "<leader>sm", function() picker.marks() end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sM", function() picker.man() end, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sp", function() picker.lazy() end, { desc = "Search for Plugin Spec" })
vim.keymap.set("n", "<leader>sq", function() picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sR", function() picker.resume() end, { desc = "Resume" })
vim.keymap.set("n", "<leader>su", function() picker.undo() end, { desc = "Undo History" })
vim.keymap.set("n", "<leader>uC", function() picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP
vim.keymap.set("n", "gd", function() picker.lsp_definitions() end, { desc = "Goto Definition" })
vim.keymap.set("n", "gD", function() picker.lsp_declarations() end, { desc = "Goto Declaration" })
vim.keymap.set("n", "gr", function() picker.lsp_references() end, { nowait = true, desc = "References" })
vim.keymap.set("n", "gI", function() picker.lsp_implementations() end, { desc = "Goto Implementation" })
vim.keymap.set("n", "gy", function() picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
vim.keymap.set("n", "gai", function() picker.lsp_incoming_calls() end, { desc = "C[a]lls Incoming" })
vim.keymap.set("n", "gao", function() picker.lsp_outgoing_calls() end, { desc = "C[a]lls Outgoing" })
vim.keymap.set("n", "<leader>ss", function() picker.lsp_symbols() end, { desc = "LSP Symbols" })
vim.keymap.set("n", "<leader>sS", function() picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

-- Other
vim.keymap.set("n", "<leader>z", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
vim.keymap.set("n", "<leader>Z", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })
vim.keymap.set("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
vim.keymap.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
-- vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
vim.keymap.set("n", "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
vim.keymap.set("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
vim.keymap.set("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
vim.keymap.set("n", "<c-_>", function() Snacks.terminal() end, { desc = "which_key_ignore" })
vim.keymap.set("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
vim.keymap.set("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })

-- vim.keymap.set("n", "<leader>N", function()
--   Snacks.win({
--     file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
--     width = 0.6,
--     height = 0.6,
--     wo = {
--       spell = false,
--       wrap = false,
--       signcolumn = "yes",
--       statuscolumn = " ",
--       conceallevel = 3,
--     },
--   })
-- end, { desc = "Neovim News" })
