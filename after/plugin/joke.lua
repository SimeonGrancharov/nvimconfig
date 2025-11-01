-- 🎭 Startup joke popup with noice
local shown_startup_joke = false

local function show_startup_joke()
  if shown_startup_joke then
    return
  end
  shown_startup_joke = true

  -- Fetch joke immediately
  local curl_cmd = 'curl -s -H "Accept: application/json" https://icanhazdadjoke.com/'
  local handle = io.popen(curl_cmd)

  if not handle then
    vim.notify("🎭 Failed to fetch joke!", vim.log.levels.WARN)
    return
  end

  local result = handle:read("*a")
  handle:close()

  -- Parse JSON manually (simple approach)
  local joke = result:match('"joke"%s*:%s*"([^"]+)"')

  if not joke then
    vim.notify("No joke today... you ARE the joke! 😂", vim.log.levels.INFO)
    return
  end

  -- Unescape JSON strings
  joke = joke:gsub("\\n", " "):gsub('\\"', '"'):gsub("\\/", "/")

  -- Check if noice is loaded
  local noice_ok, noice = pcall(require, "noice")
  if noice_ok and noice.notify then
    noice.notify("🎭 " .. joke, "info", {
      title = "Dad Joke of the Day",
      timeout = 8000,
    })
  else
    -- Fallback to regular notify
    vim.notify("🎭 Dad Joke: " .. joke, vim.log.levels.INFO)
  end
end

-- Show joke on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = show_startup_joke,
})
