return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      -- A list of parser names, or "all"
      -- ensure_installed = { "lua", "go", "python", "c_sharp" },
      ensure_installed = {},

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = false, -- broken on my mac

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader><leader>v",
          node_incremental = "<leader>k",
          scope_incremental = "<leader>h",
          node_decremental = "<leader>j",
        },
      },
      textobjects = { enable = true }, -- TODO: Understand what this is used for
    })

    -- Customise fold titles
    -- :help vim.v, v:foldlevel, foldtext
    -- https://vi.stackexchange.com/questions/43847/how-to-set-the-value-of-foldexpr-to-be-a-lua-function
    _G.get_fold_text = function()
      local line_length = 100
      local n_folded_lines = vim.v.foldend - vim.v.foldstart + 1
      local fold_title = vim.fn.getline(vim.v.foldstart) .. string.rep(" ", line_length)
      local folded_lines_tag = string.format("  + %s lines", n_folded_lines)
      return (string.sub(fold_title, 1, line_length - string.len(folded_lines_tag)) .. folded_lines_tag)
    end

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      callback = function()
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.opt.foldtext = "v:lua.get_fold_text()"
      end,
    })
  end,
}
