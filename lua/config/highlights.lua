-- highlights
-- See all highlight groups with :highlight
-- Also :help highlight-groups

M = {}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*",
  group = vim.api.nvim_create_augroup("DashHighlight", { clear = true }),
  callback = function()
    vim.cmd([[
    syntax match SpecialDashes /[–—]/ display containedin=ALL
    highlight link SpecialDashes Underlined
  ]])
  end,
})

local dark_border = "#770077"
local light_border = "#FFAAFF"

local dark_hls = {
  ["@comment"] = { fg = "#999999" },
  ["@comment.documentation"] = { fg = "#999999" },
  DiagnosticUnnecessary = { bg = "#333333" },
  WinSeparator = { bg = dark_border },
  StatusLine = { bg = dark_border },
  StatusLineNC = { bg = dark_border },
  MiniStatuslineModeNormal = { bg = dark_border },
  MiniStatuslineInactive = { bg = dark_border },
  MiniStatuslineFilename = { bg = dark_border },
  LineNr = { fg = "#FF66FF" },
  LineNrAbove = { fg = "#777777" },
  LineNrBelow = { fg = "#777777" },
}

local light_hls = {
  DiagnosticUnnecessary = { bg = "#DDDDDD" },
  WinSeparator = { bg = light_border },
  StatusLine = { bg = light_border },
  StatusLineNC = { bg = light_border },
  MiniStatuslineModeNormal = { bg = light_border },
  MiniStatuslineInactive = { bg = light_border },
  MiniStatuslineFilename = { bg = light_border },
  LineNr = { fg = "#FF00FF" },
  LineNrAbove = { fg = "#777777" },
  LineNrBelow = { fg = "#777777" },
}

local function set_dark_highlight_groups()
  for name, opts in pairs(dark_hls) do
    vim.api.nvim_set_hl(0, name, opts)
  end
end

local function set_light_highlight_groups()
  for name, opts in pairs(light_hls) do
    vim.api.nvim_set_hl(0, name, opts)
  end
end

M.set_dark_highlight_groups = set_dark_highlight_groups
M.set_light_highlight_groups = set_light_highlight_groups
set_dark_highlight_groups()

return M
