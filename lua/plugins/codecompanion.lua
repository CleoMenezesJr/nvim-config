-- REQUIRES (manual): NIM_BASE_URL, NIM_API_KEY, NIM_MODEL environment variables
-- exported in the shell before launching Neovim (e.g. ~/.bashrc or ~/.zshrc)
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/olimorris/codecompanion.nvim",
})

require("codecompanion").setup({
  adapters = {
    nim = function()
      return require("codecompanion.adapters").extend("openai", {
        name = "nim",
        formatted_name = "NVIDIA NIM",
        url = (os.getenv("NIM_BASE_URL") or "https://integrate.api.nvidia.com/v1") .. "/chat/completions",
        env = {
          api_key = "NIM_API_KEY",
        },
        schema = {
          model = {
            default = os.getenv("NIM_MODEL") or "meta/llama-3.1-70b-instruct",
          },
        },
      })
    end,
  },
  strategies = {
    chat = { adapter = "nim" },
    inline = { adapter = "nim" },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>",
  { desc = "AI actions" })
vim.keymap.set("n", "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>",
  { desc = "AI chat toggle" })
vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>",
  { desc = "AI inline" })
