vim.pack.add(
  { { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") } },
  { load = true, confirm = false }
)

require('blink.cmp').setup({
  keymap = { preset = 'default' },
  snippets = {
    preset = "default",
  },
  cmdline = { enabled = false },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        border = 'rounded',
      },
    },
    accept = { auto_brackets = { enabled = true }, },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono'
  },
  signature = { enabled = true }
})
