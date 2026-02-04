-- Neo-tree 파일 탐색기 설정
-- .env 등 숨김 파일(dotfiles)을 표시하도록 설정

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- 필터링된 항목을 보이게 설정
          show_hidden_count = true, -- 숨겨진 파일 개수 표시
          hide_dotfiles = false, -- 도트파일 숨기지 않음 (핵심 설정!)
          hide_gitignored = false, -- .gitignore 파일도 표시
          hide_by_name = {
            ".git", -- .git 디렉토리만 숨김
            "node_modules", -- node_modules 숨김
            -- ".DS_Store", -- 원하면 여기에 추가
          },
          never_show_by_pattern = {
            -- 패턴으로 숨길 파일 (선택사항)
          },
          never_show = {
            -- 절대 표시하지 않을 파일/폴더 (선택사항)
          },
        },
        -- 현재 파일 자동 추적
        follow_current_file = {
          enabled = true,
        },
      },
    },
  },
}
