vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight text on yank",
  group = vim.api.nvim_create_augroup("text-yank-highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWrite", {
  desc = "Store folds before saving",
  group = vim.api.nvim_create_augroup("save-folds-on-write", {}),
  command = "mkview",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Load folds after saving",
  group = vim.api.nvim_create_augroup("load-folds-after-save", {}),
  command = "silent! loadview",
})

-- tracking how often because only want to do this once per file
-- and "NewBuf" doesn't cut it
local times_opened = {}
vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Ensure folds are open",
  group = vim.api.nvim_create_augroup("PreOpenFolds", {}),
  callback = function()
    local filename = vim.fn.expand("%:p")
    if times_opened[filename] == nil then
      times_opened[filename] = 0
    end
    times_opened[filename] = times_opened[filename] + 1
    if times_opened[filename] >= 3 then
      -- For some reason, this event gets triggered twice
      -- and only on the second trigger does the set fold level persist
      return
    end

    -- An equivalent-ish version of vim.fn.execute(":let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))")
    local line_count = vim.api.nvim_buf_line_count(0)
    local max_fold_level = 0
    for line_number = 1, line_count do
      local line_fold_level = vim.treesitter.foldexpr(line_number)
      line_fold_level = line_fold_level:gsub(">", "") + 0
      max_fold_level = math.max(max_fold_level, line_fold_level)
    end
    local min_starting_fold_level = 2 -- to avoid annoying auto folding in new file
    vim.opt.foldlevel = vim.fn.max({ max_fold_level, min_starting_fold_level })
  end,
})
