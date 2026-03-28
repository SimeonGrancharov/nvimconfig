-- Polls /tmp/claude-code-status.json written by ~/.claude/statusline.sh
-- and exposes lualine components for Claude Code session data.

local M = {}

local STATUS_FILE = "/tmp/claude-code-status.json"
local POLL_INTERVAL_MS = 2000
local STALE_THRESHOLD_S = 300

local cached_data = nil
local file_mtime = 0
local timer = nil

local function get(tbl, ...)
  local val = tbl
  for _, key in ipairs({ ... }) do
    if type(val) ~= "table" then return nil end
    val = val[key]
  end
  return val
end

local function format_duration(ms)
  if not ms or ms == 0 then return "0s" end
  local s = math.floor(ms / 1000)
  if s >= 3600 then
    return string.format("%dh%dm", math.floor(s / 3600), math.floor((s % 3600) / 60))
  elseif s >= 60 then
    return string.format("%dm%ds", math.floor(s / 60), s % 60)
  end
  return s .. "s"
end

local function read_status()
  local stat = vim.uv.fs_stat(STATUS_FILE)
  if not stat then
    cached_data = nil
    return
  end

  if stat.mtime.sec == file_mtime then return end
  file_mtime = stat.mtime.sec

  if (os.time() - stat.mtime.sec) > STALE_THRESHOLD_S then
    cached_data = nil
    return
  end

  local f = io.open(STATUS_FILE, "r")
  if not f then
    cached_data = nil
    return
  end

  local content = f:read("*a")
  f:close()

  local ok, data = pcall(vim.json.decode, content)
  if ok and type(data) == "table" then
    cached_data = data
  end
end

local function is_active()
  if not cached_data then return false end
  local stat = vim.uv.fs_stat(STATUS_FILE)
  if not stat then return false end
  return (os.time() - stat.mtime.sec) <= STALE_THRESHOLD_S
end

function M.setup()
  if timer then return end
  timer = vim.uv.new_timer()
  timer:start(0, POLL_INTERVAL_MS, vim.schedule_wrap(read_status))
end

function M.is_active()
  return is_active()
end

function M.model()
  if not is_active() then return "" end
  return get(cached_data, "model", "display_name") or ""
end

function M.context()
  if not is_active() then return "" end
  local pct = get(cached_data, "context_window", "used_percentage")
  if not pct then return "" end
  pct = math.floor(pct)
  local filled = math.floor(pct * 10 / 100)
  return string.rep("█", filled) .. string.rep("░", 10 - filled) .. " " .. pct .. "%%"
end

function M.context_color()
  if not is_active() then return nil end
  local pct = get(cached_data, "context_window", "used_percentage")
  if not pct then return nil end
  if pct < 50 then return { fg = "#4DD4FF" } end
  if pct < 80 then return { fg = "#f9e2af" } end
  return { fg = "#FF5370" }
end

function M.cost()
  if not is_active() then return "" end
  local usd = get(cached_data, "cost", "total_cost_usd")
  if not usd or usd == 0 then return "" end
  return string.format("$%.2f", usd)
end

function M.duration()
  if not is_active() then return "" end
  local ms = get(cached_data, "cost", "total_duration_ms")
  if not ms then return "" end
  return format_duration(ms)
end

function M.lines()
  if not is_active() then return "" end
  local added = get(cached_data, "cost", "total_lines_added") or 0
  local removed = get(cached_data, "cost", "total_lines_removed") or 0
  if added == 0 and removed == 0 then return "" end
  return "+" .. added .. " -" .. removed
end

return M
