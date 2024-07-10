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
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end
    }
    opts.sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = "luasnip" }
    }, {
      { name = "buffer" },
    })

    opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {
      ["<CR>"] = cmp.mapping(function(fallback)
        print("<CR>")
        if cmp.visible() then
          print("  visible")
          if luasnip.expandable() then
            print("    expandable")
            luasnip.expand()
          else
            print("    else")
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true, })
          end
        else
          print("  else")
          fallback()
        end
      end),

      ["<Tab>"] = cmp.mapping(function(fallback)
        print("<Tab>")
        if cmp.visible() then
          print("  visible")
          cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
          print("  locally_jumpable")
          luasnip.jump(1)
        else
          print("  else")
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        print("<S-Tab>")
        if cmp.visible() then
          print("  visible")
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          print("  locally_jumpable")
          luasnip.jump(-1)
        else
          print("  else")
          fallback()
        end
      end, { "i", "s" }),
    })

    return opts
  end,
}