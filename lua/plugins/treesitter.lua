return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "vue", "typescript", "html", "css"  }, -- Adaugă `vue`
      sync_install = false,                                                                                       -- Instalează limbajele sincron
      auto_install = true,                                                                                        -- Instalează automat limbajele lipsă
      ignore_install = {},                                                                                        -- Poți ignora limbajele pe care nu le dorești
      highlight = { enable = true },                                                                              -- Activează evidențierea sintaxei
      indent = { enable = true },                                                                                 -- Activează indentarea automată
      modules = {},                                                                                               -- Dacă ai module suplimentare, le poți configura aici
    })
  end
}
