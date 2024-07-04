return {
  "neovim/nvim-lspconfig",
  lazy = true,
  dependencies = { "hrsh7th/nvim-cmp" },
  ft = { "c", "h", "cpp", "hpp", "cxx", "hxx" },
  config = function()
    require'lspconfig'.clangd.setup{}
  end,
}