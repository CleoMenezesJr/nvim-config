-- REQUIRES (manual): npm install -g @anthropic-ai/claude-code inside the Neovim Flatpak
-- REQUIRES (manual): claude auth login (inside the Flatpak)
vim.pack.add({ "https://github.com/coder/claudecode.nvim" })

require("claudecode").setup({
  auto_start = true,
  track_selection = true,
  focus_after_send = false,
  terminal = {
    provider = "snacks",
    split_side = "right",
    split_width_percentage = 0.35,
    auto_close = true,
  },
  diff_opts = {
    layout = "vertical",
    open_in_new_tab = false,
    keep_terminal_focus = false,
  },
})

-- Terminal
vim.keymap.set("n", "<leader>ak", "<cmd>ClaudeCode<cr>", { desc = "Claude Code toggle" })
-- Context
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Claude Code send selection" })
vim.keymap.set("n", "<leader>aA", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Claude Code add current file" })
-- Diff review
vim.keymap.set("n", "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Claude Code diff accept" })
vim.keymap.set("n", "<leader>aN", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Claude Code diff deny" })
