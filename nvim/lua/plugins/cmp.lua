return {
  "hrsh7th/nvim-cmp",
  lazy = true,
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require("cmp")
    local luasnip = require("luasnip")

    opts.snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end
    }
    opts.sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = "luasnip" }
    }, {
      { name = "buffer" },
    })

    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      -- ['<CR>'] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --       if luasnip.expandable() then
      --           luasnip.expand()
      --       else
      --           cmp.confirm({
      --               select = true,
      --           })
      --       end
      --   else
      --       fallback()
      --   end
      -- end),

      -- ["<CR>"] = cmp.mapping({
      --   i = function(fallback)
      --     if cmp.visible() and cmp.get_active_entry() then
      --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      --     else
      --       fallback()
      --     end
      --   end,
      --   s = cmp.mapping.confirm({ select = true }),
      --   c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      -- }),

      -- ["<CR>"] = cmp.mapping({
      --   i = function(fallback)
      --     if cmp.visible() and cmp.get_active_entry() then
      --       cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      --     else
      --       fallback()
      --     end
      --   end,
      --   s = cmp.mapping.confirm({ select = true }),
      --   c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      -- }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    })

    -- opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
    --   ["<Tab>"] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --       -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
    --       cmp.select_next_item()
    --     elseif vim.snippet.active({ direction = 1 }) then
    --       vim.schedule(function()
    --         vim.snippet.jump(1)
    --       end)
    --     elseif has_words_before() then
    --       cmp.complete()
    --     else
    --       fallback()
    --     end
    --   end, { "i", "s" }),
    --   ["<S-Tab>"] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --       cmp.select_prev_item()
    --     elseif vim.snippet.active({ direction = -1 }) then
    --       vim.schedule(function()
    --         vim.snippet.jump(-1)
    --       end)
    --     else
    --       fallback()
    --     end
    --   end, { "i", "s" }),
    -- })


    return opts
  end,
}



-- return {
--   "hrsh7th/nvim-cmp",
--   lazy = true,
--   config = function(_, opts)
--     -- Set up nvim-cmp.
--     local cmp = require'cmp'

--     cmp.setup({
--         snippet = {
--         -- REQUIRED - you must specify a snippet engine
--         expand = function(args)
--           -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--           -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--           -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--           -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--           vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
--         end,
--       },
--       window = {
--         -- completion = cmp.config.window.bordered(),
--         -- documentation = cmp.config.window.bordered(),
--       },
--       mapping = cmp.mapping.preset.insert({
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--       }),
--       sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         -- { name = 'vsnip' }, -- For vsnip users.
--         -- { name = 'luasnip' }, -- For luasnip users.
--         -- { name = 'ultisnips' }, -- For ultisnips users.
--         -- { name = 'snippy' }, -- For snippy users.
--       }, {
--         { name = 'buffer' },
--       })
--     })
--   end,
-- }
