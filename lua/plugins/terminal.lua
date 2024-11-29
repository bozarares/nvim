return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    -- Configurare de bază pentru toggleterm.nvim
    require("toggleterm").setup({
      open_mapping = [[<c-§>]], -- Apasă Ctrl+§ pentru a deschide terminalul
      direction = "horizontal",      -- Mod implicit: fereastră flotantă
      size = 20,                -- Dimensiunea terminalului
      shade_terminals = true,   -- Terminal întunecat pentru lizibilitate mai bună
      float_opts = {            -- Opțiuni pentru modul floating
        border = "curved",
        winblend = 3,
      },
    })

    -- Mapări pentru moduri diferite
    vim.keymap.set("n", "<leader>th", function()
      require("toggleterm").toggle(1, nil, nil, "horizontal") -- Deschide terminal în modul orizontal
    end, { desc = "Toggle terminal horizontal" })

    vim.keymap.set("n", "<leader>tv", function()
      require("toggleterm").toggle(1, nil, nil, "vertical") -- Deschide terminal în modul vertical
    end, { desc = "Toggle terminal vertical" })

    vim.keymap.set("n", "<leader>tf", function()
      require("toggleterm").toggle(1, nil, nil, "float") -- Deschide terminal în modul flotant
    end, { desc = "Toggle terminal float" })

    vim.keymap.set("n", "<leader>tt", function()
      require("toggleterm").toggle(1, nil, nil, "tab") -- Deschide terminal în tab nou
    end, { desc = "Toggle terminal in tab" })
  end,
}

