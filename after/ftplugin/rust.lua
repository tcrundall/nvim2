local bmap = vim.api.nvim_buf_set_keymap

bmap(0, "n", "<leader><leader>t", '?\\<fn\\><cr>wyiw:!cargo test <c-r>"<cr>', { desc = "[T]est current test" })
