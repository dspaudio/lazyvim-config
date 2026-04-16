-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    -- command-line window에서는 실행하지 않음
    if vim.fn.getcmdwintype() == "" and vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  command = "echohl WarningMsg | echo '파일이 외부에서 변경되었습니다' | echohl None",
})

-- Git 브랜치 전환 후 존재하지 않는 파일의 버퍼를 자동 삭제
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  callback = function(args)
    local bufnr = args.buf
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name ~= "" and not vim.uv.fs_stat(name) and vim.bo[bufnr].buftype == "" then
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end
      end)
    end
  end,
})
