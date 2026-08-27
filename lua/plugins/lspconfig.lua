vim.pack.add({
  --   "https://github.com/saghen/blink.cmp",
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
    filetypes = { "vue", "html" }
  },
  emmet_language_server = {
    init_options = {
      showExpandedAbbreviation = "always",
      showAbbreviationSuggestions = true,
    },
  },
  ruff = {},
  docker_language_server = {
    filetypes = { 'dockerfile', 'yaml.docker-compose' },
  },
}

-- Setup servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for server, config in pairs(servers) do
  -- config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  config.capabilities = capabilities

  vim.lsp.enable(server)
  if config then
    vim.lsp.config(server, config)
  end
end

-- LSP config
vim.lsp.inlay_hint.enable()
vim.lsp.inline_completion.enable()
vim.diagnostic.config({
  virtual_text = true,
  -- virtual_lines = true,
  underline = true
})

-- A set of options for better completion experience. See `:h completeopt`
vim.opt.completeopt = { "menuone", "noinsert", "preinsert", "popup" }

-- Hides the ins-completion-menu messages. See `:h shm-c`
vim.opt.shortmess:append "c"

-- Make completion menu appear whenever you type something.
-- Example from: https://neovim.io/doc/user/lsp.html#lsp-attach
-- Optional: trigger autocompletion on EVERY keypress. May be slow!
local chars = {}
for i = 32, 126 do
  table.insert(chars, string.char(i))
end

-- LSP auto completion
local kind_icons = {
  Text          = '󰉿',
  Method        = '󰆧',
  Function      = '󰊕',
  Constructor   = '',
  Field         = '󰜢',
  Variable      = '󰀫',
  Class         = '󰠱',
  Interface     = '',
  Module        = '',
  Property      = '󰜢',
  Unit          = '󰑭',
  Value         = '󰎠',
  Enum          = '',
  Keyword       = '󰌋',
  Snippet       = '',
  Color         = '󰏘',
  File          = '󰈙',
  Reference     = '󰈇',
  Folder        = '󰉋',
  EnumMember    = '',
  Constant      = '󰏿',
  Struct        = '󰙅',
  Event         = '',
  Operator      = '󰆕',
  TypeParameter = '',
}

local kind_hl = {
  Text          = 'String',
  Method        = 'Function',
  Function      = 'Function',
  Constructor   = 'Special',
  Field         = '@variable.member',
  Variable      = '@variable',
  Class         = 'Type',
  Interface     = 'Type',
  Module        = '@module',
  Property      = '@property',
  Unit          = 'Number',
  Value         = 'Number',
  Enum          = 'Type',
  Keyword       = 'Keyword',
  Snippet       = 'Conceal',
  Color         = 'Special',
  File          = 'Directory',
  Reference     = '@markup.link',
  Folder        = 'Directory',
  EnumMember    = 'Constant',
  Constant      = 'Constant',
  Struct        = 'Type',
  Event         = 'Special',
  Operator      = 'Operator',
  TypeParameter = 'Type',
}

local kind_map = {
  [1] = "Text",
  [2] = "Method",
  [3] = "Function",
  [4] = "Constructor",
  [5] = "Field",
  [6] = "Variable",
  [7] = "Class",
  [8] = "Interface",
  [9] = "Module",
  [10] = "Property",
  [11] = "Unit",
  [12] = "Value",
  [13] = "Enum",
  [14] = "Keyword",
  [15] = "Snippet",
  [16] = "Color",
  [17] = "File",
  [18] = "Reference",
  [19] = "Folder",
  [20] = "EnumMember",
  [21] = "Constant",
  [22] = "Struct",
  [23] = "Event",
  [24] = "Operator",
  [25] = "TypeParameter",
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil and client:supports_method("textDocument/completion") then
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or 'Text'
          local icon = kind_icons[kind] or ''
          local label = item.label or ''
          return {
            abbr = icon .. ' ' .. label,
            kind_text = kind,
            kind = kind_map[item.kind] or item.kind,
            abbr_hlgroup = kind_hl[kind]
          }
        end,
      })
    end
  end,
})
