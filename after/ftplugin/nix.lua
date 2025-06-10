vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2

vim.api.nvim_buf_set_keymap(0, "n", "<leader><leader>x", "<cmd>w | !nix-instantiate --eval --strict %<cr>", {})
