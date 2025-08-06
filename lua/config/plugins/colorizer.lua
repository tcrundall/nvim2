return {
  "chrisbra/Colorizer",
  lazy = false,
  init = function()
    vim.g.colorizer_auto_filetype = "dap-repl"
    vim.g.colorizer_disable_bufleave = 1

    vim.api.nvim_create_autocmd("FileType", {
      desc = "Force colorize on dap-repl",
      pattern = "dap-repl.*",
      group = vim.api.nvim_create_augroup("auto_colorize", { clear = true }),
      callback = function()
        vim.cmd("ColorHighlight!")
      end,
    })

    local function no_bold()
      print(vim.api.nvim_buf_get_name(0))
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      for i, line in ipairs(lines) do
        lines[i] = line:gsub("[1", "[0")
      end
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end

    vim.api.nvim_create_user_command("NoBold", function()
      no_bold()
    end, {})

    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
      callback = function()
        print("Text changed!!!")
        no_bold()
      end,
    })
  end,
}
