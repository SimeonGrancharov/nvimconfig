# Neovim Config

## Claude Code Statusline Setup

The lualine config includes a Claude Code statusline integration that shows model, context usage, cost, duration, and lines changed. Since the required files live outside this repo (`~/.claude/`), you need to set them up manually on each machine.

### 1. Create the statusline script

```bash
mkdir -p ~/.claude
cat > ~/.claude/statusline.sh << 'EOF'
#!/bin/bash
read -r DATA
echo "$DATA" > /tmp/claude-code-status.json
EOF
chmod +x ~/.claude/statusline.sh
```

### 2. Add statusLine to Claude Code settings

Add the following to `~/.claude/settings.json` (create it if it doesn't exist):

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh"
  }
}
```
