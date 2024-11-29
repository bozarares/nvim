return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets", -- Adaugă această linie
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Încarcă snippets din friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    local sources = {
      {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- Asigură-te că luasnip este inclus
        { name = "nvim_lua" },
      },
      {
        { name = "buffer" },
        { name = "path" },
      },
    }

    local mappings = {
      ["<C-b>"] = cmp.mapping.scroll_docs(-3),
      ["<C-f>"] = cmp.mapping.scroll_docs(3),
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-space>"] = cmp.mapping.complete(),
      ["<C-j>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      -- Adaugă mapping-ul pentru Enter
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }

    local winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search"

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Utilizează LuaSnip pentru a expanda snippets
        end,
      },
      mapping = cmp.mapping.preset.insert(mappings),
      sources = cmp.config.sources(sources[1], sources[2]),
      window = {
        completion = cmp.config.window.bordered({ winhighlight = winhighlight, border = "rounded" }),
        documentation = cmp.config.window.bordered({ winhighlight = winhighlight, border = "rounded" }),
        -- Elimină linia 'preview' deoarece nu este o opțiune validă
        -- preview = cmp.config.window.bordered({ winhighlight = winhighlight, border = "rounded" }),
      },
      experimental = {
        ghost_text = true, -- Opțional: afișează textul fantomă al completărilor
      },
      view = { docs = { auto_open = true }, entries = { follow_cursor = true } },
      -- Elimină setarea 'autocomplete' dacă nu este necesară
      -- opts.completion = { autocomplete = nil },
    })

    -- Configurație pentru cmdline
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
        { name = "path" },
      },
      view = { entries = { follow_cursor = false } },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "cmdline" },
        { name = "path" },
        { name = "buffer" },
      }),
      view = { entries = { follow_cursor = false } },
    })

    return opts
  end,
}
