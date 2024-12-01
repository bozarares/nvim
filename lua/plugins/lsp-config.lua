return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "volar", "ts_ls", "pyright", "intelephense", "eslint", "tailwindcss" },
      })

      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Capacități globale
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Funcția globală `on_attach`
      local on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end

    -- https://github.com/vuejs/language-tools/
    local mason_registry = require("mason-registry")
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
      -- .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
      .. "/node_modules/@vue/language-server"

    -- local vue_language_server_path =
    --   "/home/efrayanglain/.nvm/versions/node/v20.10.0/lib/node_modules/@vue/typescript-plugin"

    lspconfig.ts_ls.setup({
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
          },
        },
      },
      filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
    })
lspconfig.tailwindcss.setup {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "package.json"),
  settings = {},
}
      -- Configurarea handler-elor pentru alte servere
      mason_lspconfig.setup_handlers({
        function(server_name)
          if server_name ~= "volar" and server_name ~= "ts_ls" then
            lspconfig[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
            })
          end
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        config = {
          vim.keymap.set("n", "<leader>nb", ":Navbuddy<CR>", { noremap = true, silent = true })
        },
        opts = { lsp = { auto_attach = true } }
      }
    }
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- doar pentru fișiere Lua
    opts = {
      library = {
        -- Încarcă tipuri luvit când cuvântul `vim.uv` este găsit
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}

