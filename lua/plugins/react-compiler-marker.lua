return {
  "SimeonGrancharov/react-compiler-marker",
  branch = "feat/implement-diagnostics-in-lsp",

  event = { "BufReadPre *.js,*.jsx,*.ts,*.tsx", "BufNewFile *.js,*.jsx,*.ts,*.tsx" },

  build = "npm install && BUILD_TARGET=nvim node esbuild.js --production && cp -r packages/nvim-client/lua packages/nvim-client/plugin packages/nvim-client/server .",

  opts = {},
}
