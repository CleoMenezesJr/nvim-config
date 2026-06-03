vim.pack.add({
  "https://github.com/navarasu/onedark.nvim",
  "https://github.com/f-person/auto-dark-mode.nvim",
})

local function apply(dark)
  vim.o.background = dark and "dark" or "light"
  require("onedark").setup({
    style = dark and "dark" or "light",
    transparent = true,
  })
  require("onedark").load()
end

require("auto-dark-mode").setup({
  set_dark_mode = function() apply(true) end,
  set_light_mode = function() apply(false) end,
})
