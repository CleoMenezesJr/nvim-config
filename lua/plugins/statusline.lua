local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
local cur_lin = vim.api.nvim_get_hl(0, { name = "DiagnosticInfo", link = false })
vim.api.nvim_set_hl(0, "StlMode", { fg = pms.fg, bg = vis.bg })
vim.api.nvim_set_hl(0, "StlGit", { fg = dir.fg, bg = pms.bg })
vim.api.nvim_set_hl(0, "StlWorkspace", { fg = dir.fg, bg = cur_lin.bg })

local modes = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  c = "COMMAND",
  t = "TERMINAL",
  R = "REPLACE",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
}


Lsp_progress = ""
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local value = ev.data.params.value
    if value.kind ~= "end" then
      Lsp_progress = "%#StlWorkspace# " .. value.title .. " " .. value.percentage .. "%%" .. " %*"
    else
      Lsp_progress = ""
    end
    vim.cmd.redrawstatus()
  end,
})

function _G._statusline()
  local mode = " " .. modes[vim.fn.mode()] or vim.fn.mode():upper()
  local branch = vim.b.git_branch and "%#StlGit# " .. " " .. vim.b.git_branch .. " %*" or ""
  local path = " " .. (vim.b.rel_path or "%f")

  local diag = ""
  local counts = vim.diagnostic.count(0) or {}
  local labels = { " ", " ", " ", " " }
  local hls = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
  for i = 1, 4 do
    if counts[i] and counts[i] > 0 then
      diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. "%* "
    end
  end


  local is_modified = vim.api.nvim_get_option_value("modified", { buf = 0 })
  local modified_icon = is_modified and "  " or ""

  return "%#StlMode# " ..
      mode ..
      " %*" ..
      branch ..
      " " .. path .. modified_icon .. " " .. Lsp_progress .. "%=" .. diag .. "︱" .. vim.bo.filetype .. " ︱" .. "%l:%c"
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
    if root ~= "" then
      vim.b.git_branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+$", "")
      vim.b.rel_path = vim.fn.expand("%:p"):sub(#root + 2)
    else
      vim.b.git_branch = nil
      vim.b.rel_path = vim.fn.expand("%:p:~")
    end
  end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    vim.cmd("redrawstatus!")
  end,
})

vim.o.statusline = "%!v:lua._statusline()"
