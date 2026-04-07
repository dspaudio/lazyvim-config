return {
  "coder/claudecode.nvim",
  opts = {
    terminal = {
      provider = "external",
      provider_opts = {
        -- tmux split-window로 오른쪽에 50% 비율로 Claude Code 실행
        -- -h: 수평 분할 (좌우), -l 50%: 50% 너비, -c: 작업 디렉토리
        external_terminal_cmd = "tmux split-window -h -l 50%% -c %s %s",
      },
    },
  },
}
