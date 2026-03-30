local M = {}

local toggle_terms = {}

local function float_win_opts()
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  return {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  }
end

local function hide_float(cmd)
  local state = toggle_terms[cmd]
  if state and state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
  end
end

local function setup_auto_hide(cmd)
  local state = toggle_terms[cmd]
  if not state or not state.buf then return end

  local group_name = "float_term_" .. cmd:gsub("%s", "_")
  local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
  state.augroup = augroup

  vim.api.nvim_create_autocmd("WinLeave", {
    group = augroup,
    buffer = state.buf,
    callback = function()
      vim.schedule(function() hide_float(cmd) end)
    end,
  })
end

function M.open(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, float_win_opts())

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.schedule(function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end)
    end,
  })

  vim.cmd("startinsert")
end

function M.toggle(cmd)
  local state = toggle_terms[cmd]

  if state and state.win and vim.api.nvim_win_is_valid(state.win) then
    hide_float(cmd)
    return
  end

  if state and state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    state.win = vim.api.nvim_open_win(state.buf, true, float_win_opts())
    setup_auto_hide(cmd)
    vim.cmd("startinsert")
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "hide"
  local win = vim.api.nvim_open_win(buf, true, float_win_opts())

  vim.fn.termopen(cmd, {
    on_exit = function()
      vim.schedule(function()
        local s = toggle_terms[cmd]
        if s then
          if s.augroup then
            vim.api.nvim_del_augroup_by_id(s.augroup)
          end
          if s.win and vim.api.nvim_win_is_valid(s.win) then
            vim.api.nvim_win_close(s.win, true)
          end
          if s.buf and vim.api.nvim_buf_is_valid(s.buf) then
            vim.api.nvim_buf_delete(s.buf, { force = true })
          end
        end
        toggle_terms[cmd] = nil
      end)
    end,
  })

  toggle_terms[cmd] = { buf = buf, win = win }
  setup_auto_hide(cmd)
  vim.cmd("startinsert")
end

return M
