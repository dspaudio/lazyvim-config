# 💤 LazyVim config for PHP Laravel environment

Based on LazyVim starter.

# 설정 클론

git clone <your-config-repo> ~/.config/nvim

# Neovim 실행 (플러그인 자동 설치)

nvim
첫 실행 시 lazy.nvim이 모든 플러그인을 자동으로 설치합니다.
선택적 복원

# 설정만 복원

mv ~/.config/nvim.bak ~/.config/nvim

# 플러그인 캐시 제거하여 재설치

rm -rf ~/.local/share/nvim/lazy
nvim  # 플러그인 재설치
