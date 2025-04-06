vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.opt_local.foldmethod ~= "manual" then
      return
    end

    if require("nvim-treesitter.parsers").has_parser() then
      print("setting fold method: expr")
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      print("setting fold method: syntax")
      -- vim.opt.foldmethod = "indent"
      vim.opt_local.foldmethod = "indent"
    end
    vim.opt.foldenable = false
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text on yank",
  group = vim.api.nvim_create_augroup("text-yank-highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
