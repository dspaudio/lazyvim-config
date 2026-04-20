---@diagnostic disable: undefined-global
local terminal_opts
if vim.env.TMUX then
  terminal_opts = {
    provider = "external",
    provider_opts = {
      external_terminal_cmd = "tmux split-window -h -l 50%% -c %s %s",
    },
  }
else
  terminal_opts = {
    provider = "snacks",
    split_side = "right",
    split_width_percentage = 0.50,
  }
end

return {
  "coder/claudecode.nvim",
  opts = {
    terminal = terminal_opts,
    focus_after_send = true,
  },
}
