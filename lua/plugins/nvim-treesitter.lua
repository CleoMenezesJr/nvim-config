vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }
})

-- nvim-treesitter removed the nvim-treesitter.configs module.
-- Treesitter highlighting is enabled by default in Neovim 0.10+.
-- Parsers are auto-installed on FileType via vim.treesitter.language.add.

-- Disable treesitter for large files (100 KB)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf = args.buf
    local max_filesize = 100 * 1024
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      vim.treesitter.stop(buf)
    end
  end,
})

-- Auto-install parsers on demand
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.language.add, args.match)
  end,
})

-- Disable vim regex highlighting (replaces additional_vim_regex_highlighting = false)
vim.opt.regexpengine = 0
