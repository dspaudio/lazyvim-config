-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_php_lsp = "intelephense"

-- 외부 파일 수정 자동 감지 및 리로드
vim.opt.autoread = true
vim.opt.wrap = true -- 화면 끝에서 soft wrap
vim.opt.linebreak = true -- 단어 기준 줄바꿈
vim.opt.breakindent = true -- 줄 바뀐 부분 들여쓰기 (선택 사항)
