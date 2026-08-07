function FindLast(s, pattern, end_pos)
  local ix = 0 ---@type integer | nil
  local position = nil
  while ix ~= nil and ix < end_pos do
    ix = string.find(s, pattern, ix)
    if ix == nil or ix > end_pos then
      break
    end
    position = ix
    ix = ix + 1
  end
  return position
end

local function jump_to_markdown_header(link)
  local markdown_header = link:sub(2)
  local search_phrase = "^#\\+\\s*" .. markdown_header:gsub("-", ".*")
  local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  vim.api.nvim_feedkeys("/" .. search_phrase .. enter .. "nzz:noh" .. enter, "n", true)
end

local function jump_to_file(address)
  local relative_link = address:sub(1, 1) == "."

  if relative_link then
    local dir_of_current_file = vim.fn.expand("%:h")
    address = vim.fn.simplify(dir_of_current_file .. "/" .. address)
  end

  -- openable files
  local openable_extensions = { "pdf", "png", "jpg", "jpeg", "xlsx", "doc", "docx" }
  for _, extension in pairs(openable_extensions) do
    if vim.endswith(address, extension) then
      address = address:gsub(" ", "\\ ")
      vim.ui.open(address)
      return
    end
  end

  -- TODO: Support jumping direct to line number, only support `#L` for now
  local line_number_seps = { "#L" } -- , ":" }

  local line_number = nil
  for _, sep in ipairs(line_number_seps) do
    local start, match_end = address:find(sep)
    if start ~= nil then
      line_number = address:sub(match_end + 1)
      address = address:sub(1, start - 1)
    end
  end

  local buf_nr = vim.uri_to_bufnr(address)
  local win_nr = vim.api.nvim_open_win(buf_nr, true, { split = "below", win = -1 })

  if line_number ~= nil then
    vim.api.nvim_win_set_cursor(win_nr, { tonumber(line_number), 0 })
  end
end

local function is_valid_markdown_link(str, open_paren_ix, close_paren_ix)
  -- a valid link will not contain any parenthesis with in it
  -- and the open parenthesis will be preceded by a closing square bracket
  local extra_close_paren_ix = str:sub(open_paren_ix, close_paren_ix - 1):find("%)")
  local leading_char = str:sub(open_paren_ix - 1, open_paren_ix - 1)
  return extra_close_paren_ix == nil and leading_char == "]"
end

local function extract_address_from_string(str, search_start)
  local open_paren_ix, close_paren_ix = nil, nil

  while true do
    close_paren_ix = str:find("%)", search_start)
    if close_paren_ix == nil then
      print("Could not find ')' after cursor position")
      return
    end
    open_paren_ix = FindLast(str, "%(", close_paren_ix)

    if open_paren_ix == nil then
      print("Could not find matching '(' before column " .. close_paren_ix)
      return
    end

    if is_valid_markdown_link(str, open_paren_ix, close_paren_ix) then
      break
    else
      search_start = close_paren_ix + 1
    end
  end
  return str:sub(open_paren_ix + 1, close_paren_ix - 1)
end

local function follow_link()
  local current_line = vim.api.nvim_get_current_line()
  -- Note columns are 0 indexed, but strings are 1 indexed
  local search_start = vim.api.nvim_win_get_cursor(0)[2] + 1

  local address = extract_address_from_string(current_line, search_start)
  if address == nil then
    return
  end

  if vim.startswith(address, "#") then
    jump_to_markdown_header(address)
  elseif vim.startswith(address, "http") then
    vim.ui.open(address)
  else
    jump_to_file(address)
  end
end

vim.api.nvim_create_user_command("FollowLink", function()
  follow_link()
end, {})

vim.keymap.set("n", "gl", "<cmd>FollowLink<cr>", { desc = "[G]o to [L]ink" })
