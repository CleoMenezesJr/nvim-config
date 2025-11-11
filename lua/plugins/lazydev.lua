vim.pack.add({
  "https://github.com/folke/lazydev.nvim"
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      vim.notify("Callback was run on LspAttach but no client was found!")
      return
    end

    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    if ft == 'lua' then
      require("lazydev").setup()
    end

  end,
  desc = "Run LSP setup for buffer",
  group = vim.api.nvim_create_augroup("LspSetup", {}),
  pattern = "*",
})
