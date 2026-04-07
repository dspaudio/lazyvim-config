return {
  -- catppuccin 플러그인 설정
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      term_colors = true,
    },
  },
  -- LazyVim colorscheme config
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
