return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
      formatters = {
        ["markdownlint-cli2"] = {
          prepend_args = {
            "--config",
            vim.fn.expand("~/.markdownlint-cli2.yaml"),
          },
        },
      },
    },
  },
}
