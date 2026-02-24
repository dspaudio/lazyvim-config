-- ~/.config/nvim/lua/plugins/lualine.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local cached = ""

      local function fetch_input_source()
        local script = "osascript -l JavaScript -e '"
          .. 'ObjC.import("Carbon");'
          .. 'ObjC.bindFunction("CFMakeCollectable",["id",["void *"]]);'
          .. "function run(){"
          .. "var source=$.TISCopyCurrentKeyboardInputSource();"
          .. "var nameRef=$.TISGetInputSourceProperty(source,$.kTISPropertyLocalizedName);"
          .. "return ObjC.unwrap($.CFMakeCollectable(nameRef));}"
          .. "'"
        local handle = io.popen(script)
        if not handle then
          return
        end
        local result = handle:read("*a") or ""
        handle:close()
        cached = result:gsub("%s+", "")
      end

      fetch_input_source()

      local timer = vim.uv.new_timer()
      timer:start(1000, 1000, vim.schedule_wrap(fetch_input_source))

      table.insert(opts.sections.lualine_z, {
        function()
          return cached
        end,
        color = { fg = "#282a36", bg = "#ffffff", gui = "bold" },
        separator = { left = "", right = "" },
      })
    end,
  },
}
