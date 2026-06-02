-- REQUIRES (manual): npm install -g @anthropic-ai/claude-code inside toolbox "dev"
-- REQUIRES (manual): toolbox run -c dev claude auth login
-- NOTE: flatpak-spawn --host escapes the Flatpak sandbox to call the host toolbox
vim.pack.add({ "https://github.com/coder/claudecode.nvim" })

require("claudecode").setup({
  auto_start = true,
  -- Escapes the Flatpak sandbox via flatpak-spawn, then calls the CLI inside toolbox "dev"
  terminal_cmd = "flatpak-spawn --host toolbox run -c dev claude",
})

vim.keymap.set("n", "<leader>ak", "<cmd>ClaudeCode<cr>",
  { desc = "Claude Code toggle" })
