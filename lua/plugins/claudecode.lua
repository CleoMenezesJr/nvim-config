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
-- ClaudeCodeDiffAccept calls accept_current_diff() directly (no :w), so BufWriteCmd never
-- fires. We wrap the keymap to capture target window + first hunk position while diff is
-- still active, then defer focus+cursor after cleanup finishes (~600ms for WebSocket round-trip).
vim.keymap.set("n", "<leader>ay", function()
  local target_win = vim.b.claudecode_diff_target_win
  local edit_pos = nil
  if target_win and vim.api.nvim_win_is_valid(target_win) then
    local ok, pos = pcall(vim.api.nvim_win_call, target_win, function()
      vim.cmd("normal! gg]c")
      return vim.api.nvim_win_get_cursor(0)
    end)
    if ok then edit_pos = pos end
  end
  vim.cmd("ClaudeCodeDiffAccept")
  vim.defer_fn(function()
    if target_win and vim.api.nvim_win_is_valid(target_win) then
      vim.api.nvim_set_current_win(target_win)
      if edit_pos then
        pcall(vim.api.nvim_win_set_cursor, target_win, edit_pos)
        vim.cmd("normal! zz")
      end
    end
  end, 600)
end, { desc = "Claude Code diff accept" })
vim.keymap.set("n", "<leader>aN", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Claude Code diff deny" })
