vim.pack.add({
  "https://github.com/saghen/blink.cmp",
  "https://github.com/neovim/nvim-lspconfig"
})

local vue_ls_path = vim.fn.expand("$MASON/packages/vue-language-server")
local vue_plugin_path = vue_ls_path .. "/node_modules/@vue/language-server"

-- Server configs
local servers = {
  lua_ls = {},
  -- vue_ls = {},
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = vue_plugin_path,
          languages = { "vue" },
        }
      }
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  },
  eslint = {},
  tailwindcss = { filetypes = { "vue" } },
  cssls = {},
  jsonls = {},
  html = {
    on_attach = function(client, bufnr)
      local ft = vim.bo[bufnr].filetype

      if ft == "vue" then
        client.server_capabilities.documentFormattingProvider = false
      end
    end,
    filetypes = { "vue" }
  },
  ruff = {},
}

-- Setup servers
for server, config in pairs(servers) do
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

  vim.lsp.enable(server)
  if config then
    vim.lsp.config(server, config)
  end
end

-- LSP config
vim.lsp.inlay_hint.enable()
vim.lsp.inline_completion.enable()
vim.lsp.on_type_formatting.enable()
vim.diagnostic.config({
  virtual_text = true,
  -- virtual_lines = true,
  underline = true
})
