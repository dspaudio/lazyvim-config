return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "snacks.nvim", -- Snacks가 먼저 로드되도록 명시적으로 의존성 추가
    },
    opts = function(_, opts)
      -- Snacks가 로드될 때까지 기다림
      if not _G.Snacks then
        return opts
      end
      
      -- 기존 LazyVim 설정 유지
      return opts
    end,
  },
}
