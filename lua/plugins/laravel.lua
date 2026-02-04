return {
  "adalessa/laravel.nvim",
  ft = { "php", "blade" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "tpope/vim-dotenv",
    "MunifTanjim/nui.nvim",
  },
  cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn" },
  keys = {
    { "<leader>la", ":Laravel artisan" },
    { "<leader>lr", ":Laravel routes" },
  },
  config = true,
}
