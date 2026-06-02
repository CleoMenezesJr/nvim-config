vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/nvim-mini/mini.clue",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.statusline",
  "https://github.com/nvim-mini/mini.map"
})

-- ============================================================================
-- MINI FILES
-- ============================================================================

require('mini.files').setup()

vim.keymap.set("n", "-", "<CMD>lua MiniFiles.open()<CR>", { desc = "Open Files" })

-- ============================================================================
-- MINI PAIRS
-- ============================================================================

require('mini.pairs').setup()

-- ============================================================================
-- MINI STATUSLINE
-- ============================================================================

require('mini.statusline').setup()

-- ============================================================================
-- MINI MAP
-- ============================================================================

require('mini.map').setup()

local augroup = vim.api.nvim_create_augroup("MiniMapAutoHide", { clear = true })

local map_hidden_by_exclude = false

-- TermOpen fires AFTER WinEnter when using Snacks (window is created first, then
-- the terminal process starts). So we close the map here directly rather than
-- relying on WinEnter to see the flag in time.
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function(args)
    vim.b[args.buf].minimap_disable = true
    map_hidden_by_exclude = true
    MiniMap.close()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "codecompanion",
  callback = function(args)
    vim.b[args.buf].minimap_disable = true
    map_hidden_by_exclude = true
    MiniMap.close()
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  group = augroup,
  callback = function()
    if vim.b.minimap_disable then
      map_hidden_by_exclude = true
      MiniMap.close()
    elseif map_hidden_by_exclude then
      map_hidden_by_exclude = false
      MiniMap.open()
    end
  end,
})

-- ============================================================================
-- MINI CLUE
-- ============================================================================

local miniclue = require('mini.clue')
require('mini.clue').setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },

  window = {
    delay = 500,
  },
})
