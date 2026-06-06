-- Lê NIM_API_KEY, NIM_BASE_URL e NIM_MODEL de stdpath("config")/.env
-- Se as variáveis já estão no shell (ex: ~/.bashrc), comente este bloco.
-- Necessário em ambientes onde o shell padrão é /bin/sh (ex: Flatpak),
-- onde ~/.bashrc e ~/.config/fish/config.fish não são carregados.
local env_file = vim.fn.stdpath("config") .. "/.env"
local f = io.open(env_file, "r")
if f then
  for line in f:lines() do
    local key, value = line:match("^%s*([%w_]+)=(.-)%s*$")
    if key then vim.fn.setenv(key, value) end
  end
  f:close()
end

-- REQUIRES (manual, once after install/update): baixar os binários nativos do avante.
-- Sem isso, ocorre o erro "missing avante_templates" ao enviar mensagens.
-- Rodar no terminal do host (fora do Flatpak):
--   cd ~/.var/app/io.neovim.nvim/data/nvim/site/pack/core/opt/avante.nvim && make
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/yetone/avante.nvim",
})

require("avante").setup({
  provider = "nim",
  providers = {
    nim = {
      __inherited_from = "openai",
      endpoint = os.getenv("NIM_BASE_URL") or "https://integrate.api.nvidia.com/v1",
      model = os.getenv("NIM_MODEL") or "meta/llama-3.1-70b-instruct",
      api_key_name = "NIM_API_KEY",
    },
  },
})