-- REQUIRES (manual): opencode CLI installed and on PATH (already present at
-- ~/.var/app/io.neovim.nvim/data/node/bin/opencode)
vim.pack.add({
  { src = "https://github.com/nickjvandyke/opencode.nvim", version = vim.version.range("*") },
})

local opencode_cmd = "opencode --port"
local opencode_term_opts = {
  win = { position = "right", width = 0.35, enter = false },
}

---@type opencode.Opts
vim.g.opencode_opts = {
  server = {
    start = function()
      require("snacks.terminal").open(opencode_cmd, opencode_term_opts)
    end,
  },
}

-- Sidebar toggle (mirrors <leader>ak for claudecode)
vim.keymap.set({ "n", "t" }, "<leader>ot", function()
  require("snacks.terminal").toggle(opencode_cmd, opencode_term_opts)
end, { desc = "OpenCode toggle" })

vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ") end,
  { desc = "OpenCode ask" })
vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,
  { desc = "OpenCode select" })
vim.keymap.set("n", "<leader>oA", function() require("opencode").prompt("@buffer ") end,
  { desc = "OpenCode add current file" })
vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
  { desc = "Append range to OpenCode", expr = true })
