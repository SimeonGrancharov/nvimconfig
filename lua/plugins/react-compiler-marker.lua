return {
  "SimeonGrancharov/react-compiler-marker",
  branch = "feat/implement-neovim-client", -- TODO: remove after merge to main

  event = { "BufReadPre *.js,*.jsx,*.ts,*.tsx", "BufNewFile *.js,*.jsx,*.ts,*.tsx" },

  -- Build the LSP server after clone/update
  build = "npm install && node esbuild.js --production",

  opts = {},
}
