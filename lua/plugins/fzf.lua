-- FZF 파일 검색기 설정
-- .env 등 숨김 파일(dotfiles)을 검색할 수 있도록 설정

return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<leader><space>",
        function()
          require("fzf-lua").files({
            prompt = "Files> ",
            cwd = vim.fn.getcwd(),
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find Files (root dir, include hidden)",
      },
      {
        "<leader>ff",
        function()
          require("fzf-lua").files({
            prompt = "Files> ",
            cwd = vim.fn.getcwd(),
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find Files (include hidden)",
      },
    },
  },
}
