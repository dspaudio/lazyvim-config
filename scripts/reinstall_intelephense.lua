-- Intelephense를 완전히 재설치하고 재시작하는 스크립트
-- Neovim에서 실행: :source ~/.config/nvim/scripts/reinstall_intelephense.lua

local function reinstall_intelephense()
  print("=== Intelephense 재설치 시작 ===")
  
  -- Mason을 통해 intelephense 제거
  vim.cmd("MasonUninstall intelephense")
  vim.wait(2000)
  
  -- 캐시 삭제
  os.execute("rm -rf ~/.cache/intelephense")
  os.execute("rm -rf ~/.local/state/nvim/lsp*")
  print("캐시 삭제 완료")
  
  -- Intelephense 재설치
  vim.cmd("MasonInstall intelephense")
  print("Intelephense 재설치 시작...")
  print("설치 완료 후 :LspRestart intelephense 실행하세요")
end

-- 명령어 등록
vim.api.nvim_create_user_command('ReinstallIntelephense', reinstall_intelephense, {})

print("명령어 등록 완료: :ReinstallIntelephense")
